import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_miniproject/model/ingredient.dart';
import 'package:flutter_miniproject/module/edit_meal_screen_components/recipe_input.dart';
import 'package:flutter_miniproject/module/edit_meal_screen_components/recipe_item.dart';
import 'package:flutter_miniproject/provider/meal_api_provider.dart';
import 'package:flutter_miniproject/provider/recipe_provider.dart';
import 'package:flutter_miniproject/provider/upload_image_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:flutter_miniproject/model/screen_argument.dart';
import 'package:flutter_miniproject/module/edit_meal_screen_components/mealpost_inputs_checker.dart';
import 'package:flutter_miniproject/module/edit_meal_screen_components/customtextfield.dart';
import 'package:flutter_miniproject/module/edit_meal_screen_components/invalid_dialog.dart';
import 'package:flutter_miniproject/module/edit_meal_screen_components/post_delete_dialog.dart';
import 'package:flutter_miniproject/responsive.dart';
import 'package:flutter_miniproject/provider/meal_provider.dart';
import 'package:flutter_miniproject/provider/const_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class EditMealPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    Uuid uuid = Uuid();

    String? _initialname = args.meal!.name!;

    final _namecontroller = useTextEditingController(text: _initialname);
    final _recipeTextController = useTextEditingController();
    final _networkimage = useState<String?>(args.meal!.image!);
    final _byteimage = useState<Uint8List?>(null);
    final _file = useState<FilePickerResult?>(null);
    final _recipeProvider = useProvider(recipeProvider);
    final _imageprovider = useProvider(uploadImageProvider);
    final _mealProvider = useProvider(mealProvider);

    final constants = useProvider(constantsProvider);

    final double _height = MediaQuery.of(context).size.height;

    _updateMealObject() async {
      bool status = MealPostChecker.isComplete(
          // id: args.meal!.id!,
          name: _namecontroller.text,
          ingredients: _recipeProvider.ingredients,
          image: _byteimage.value);

      if (status) {
        if (_networkimage.value == null && _byteimage.value != null) {
          await _imageprovider.uploadFile(
              file: _file.value, image: _byteimage.value, user_id: '');
        }
        final meal = Meal(
            id: args.meal!.id,
            name: _namecontroller.text,
            image: _imageprovider.url,
            mealType: args.meal!.mealType,
            ingredients: _recipeProvider.ingredients);

        // _mealProvider.updateMeal(
        //     updatedMeal: Meal(
        //         id: args.meal!.id,
        //         name: _namecontroller.text,
        //         // image: _image.value,
        //         ingredients: _recipeProvider.ingredients));
        _namecontroller.clear();
        //_image.value = null;
        _recipeTextController.clear();
        showConfirmationDialog(context, 'Your meal is successfully updated.');
      } else {
        showInvalidDialog(context);
      }
      _recipeProvider.deletePrevList();
    }

    Future _pickImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['png', 'jpeg', 'jpg']);

      if (result != null) {
        _byteimage.value = result.files.first.bytes;
        _file.value = result;
      }
    }

    useEffect(() {
      _recipeProvider.updateListIng(args.meal!.ingredients!);
      print('this');
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            constants.kDefaultPadding * 2.5,
            constants.kDefaultPadding,
            constants.kDefaultPadding * 2.5,
            constants.kDefaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: [
            if (_byteimage.value != null || _networkimage.value != null)
              Container(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.windowClose,
                        size: _height * .03,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (_byteimage.value != null) {
                          _byteimage.value = null;
                        } else {
                          _networkimage.value = null;
                        }
                      }),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(constants.kDefaultPadding - 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17.0),
                child: AspectRatio(
                  aspectRatio: 1.3,
                  child: Container(
                    width: double.infinity,
                    //height: _height * .7,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),

                    child: (_byteimage.value != null ||
                            _networkimage.value != null)
                        ? FittedBox(
                            fit: BoxFit.cover,
                            child: (_networkimage.value != null)
                                ? Image.network(_networkimage.value!)
                                : Image.memory(_byteimage.value!),
                          )
                        : IconButton(
                            //TODO: need parin to pag dinelete ni user yung image?
                            onPressed: () {
                              _pickImage();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.image,
                              size: _height * .08,
                              color: Colors.red,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(constants.kDefaultPadding),
              child: CustomTextField(
                controller: _namecontroller,
                fontsize: Responsive.isDesktop(context) ? 32 : 24,
                labelText: 'Title',
                fontweight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RecipeInput(
                      textController: _recipeTextController,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        _recipeProvider.addIngredient(
                            body: _recipeTextController.text);
                        _recipeTextController.clear();
                      },
                      child: Icon(Icons.add),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    final recipe = _recipeProvider.ingredients[i];
                    return RecipeListItem(
                      ingredient: recipe,
                    );
                  },
                  itemCount: _recipeProvider.ingredients.length,
                ),
              ),
            ),
            Center(
              child: Container(
                width: (Responsive.isDesktop(context)) ? 150 : 70,
                height: (Responsive.isDesktop(context)) ? 50 : 40,
                child: ElevatedButton(
                  onPressed: _updateMealObject,
                  child: Text('Update',
                      style: TextStyle(
                        fontSize: (Responsive.isDesktop(context)) ? 35 : 15,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
