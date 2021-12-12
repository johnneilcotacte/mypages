import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_miniproject/module/edit_meal_screen_components/recipe_input.dart';
import 'package:flutter_miniproject/module/edit_meal_screen_components/recipe_item.dart';
import 'package:flutter_miniproject/provider/current_user_provider.dart';
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

class CreateMealPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    String _initialname = '';
    Uint8List? _initialimage;
    Uuid uuid = Uuid();
    double width = MediaQuery.of(context).size.width;
    final _namecontroller = useTextEditingController(text: _initialname);
    final _recipeTextController = useTextEditingController();
    final _byteimage = useState<Uint8List?>(_initialimage);
    final constants = useProvider(constantsProvider);
    final _mealProvider = useProvider(mealProvider);
    final _recipeProvider = useProvider(recipeProvider);
    final _user = useProvider(currentUserProvider);
    final _uploadimage = useProvider(uploadImageProvider);
    final double _height = MediaQuery.of(context).size.height;
    final file = useState<FilePickerResult?>(null);
    String? _image;
    Future<void> _createMealObject() async {
      bool status = MealPostChecker.isComplete(
          //  id: '1',
          name: _namecontroller.text,
          ingredients: _recipeProvider.ingredients,
          image: _byteimage.value);

      // bool status = MealPostChecker.isComplete(meal);
      if (status) {
        _image = await _uploadimage.uploadFile(
            file: file.value,
            image: _byteimage.value,
            user_id: _user.user!.id!);
        final meal = Meal(
            id: _user.user!.id!,
            name: _namecontroller.text,
            image: _image,
            mealType: ['breakfast'],
            ingredients: _recipeProvider.ingredients);

        // _recipeProvider.deletePrevList();
        _mealProvider.addMeals(
            newMeal: meal.createtoJson(),
            user_id: _user.user!.id!,
            access_token: _user.user!.access_token!);
        _namecontroller.clear();
        _image = null;
        _recipeTextController.clear();
        showConfirmationDialog(context, 'Your meal is successfully uploaded.');
      } else {
        showInvalidDialog(context);
      }
    }

    //Sauce: https://github.com/miguelpruivo/flutter_file_picker/wiki/API#-getdirectorypath
    Future<void> _pickImage() async {
      //use filepicker rather than ImagePickerWeb. Lang kwenta yung ayaw magsupport ng sdk 2.12.0
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['png', 'jpeg', 'jpg']);

      if (result != null) {
        file.value = result;
        _byteimage.value = result.files.first.bytes;
      }
    }

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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'ADD A MEAL',
                  style: GoogleFonts.dancingScript(
                      color: Colors.black,
                      fontSize: (Responsive.isDesktop(context))
                          ? 48
                          : (Responsive.isTablet(context))
                              ? 38
                              : 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(constants.kDefaultPadding - 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17.0),
                  child: Container(
                    width: (!Responsive.isMobile(context)) ? 500 : width,
                    height: (!Responsive.isMobile(context)) ? 500 : 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    //TODO: should i remove this box, or need ba to pag naupload na yung pic kasi di na null?
                    child: (_byteimage.value != null)
                        ? FittedBox(
                            fit: BoxFit.cover,
                            child: Image.memory(_byteimage.value!),
                          )
                        : IconButton(
                            onPressed: _pickImage,
                            // onPressed: () {},
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
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(constants.kDefaultPadding),
                child: CustomTextField(
                  controller: _namecontroller,
                  fontsize: Responsive.isDesktop(context) ? 32 : 24,
                  labelText: 'Meal Title',
                  fontweight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
            SliverFillRemaining(
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
            // Expanded(
            //   child: SizedBox(
            //     height: 150,
            //     child: ListView.builder(
            //       itemBuilder: (context, i) {
            //         final recipe = _recipeProvider.ingredients[i];
            //         return RecipeListItem(
            //           ingredient: recipe,
            //         );
            //       },
            //       itemCount:  _recipeProvider.ingredients.length,
            //     ),
            //   ),
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int i) {
                  final recipe = _recipeProvider.ingredients[i];
                  return RecipeListItem(
                    ingredient: recipe,
                  );
                },
                childCount: _recipeProvider.ingredients.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  width: (Responsive.isDesktop(context)) ? 150 : 70,
                  height: (Responsive.isDesktop(context)) ? 50 : 40,
                  child: ElevatedButton(
                    onPressed: _createMealObject,
                    //onPressed: () {},
                    child: Text('Add',
                        style: TextStyle(
                          fontSize: (Responsive.isDesktop(context)) ? 35 : 15,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}















/*


ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'ADD A MEAL',
                style: GoogleFonts.dancingScript(
                    color: Colors.black,
                    fontSize: (Responsive.isDesktop(context))
                        ? 48
                        : (Responsive.isTablet(context))
                            ? 38
                            : 30),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(constants.kDefaultPadding - 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17.0),
                child: Container(
                  width: (!Responsive.isMobile(context)) ? 500 : width,
                  height: (!Responsive.isMobile(context)) ? 500 : 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  //TODO: should i remove this box, or need ba to pag naupload na yung pic kasi di na null?
                  child: (_byteimage.value != null)
                      ? FittedBox(
                          fit: BoxFit.cover,
                          child: Image.memory(_byteimage.value!),
                        )
                      : IconButton(
                          // onPressed: _pickImage,
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.image,
                            size: _height * .08,
                            color: Colors.red,
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
                labelText: 'Meal Title',
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
            // Expanded(
            //   child: SizedBox(
            //     height: 150,
            //     child: ListView.builder(
            //       itemBuilder: (context, i) {
            //         final recipe = _recipeProvider.ingredients[i];
            //         return RecipeListItem(
            //           ingredient: recipe,
            //         );
            //       },
            //       itemCount: _recipeProvider.ingredients.length,
            //     ),
            //   ),
            // ),
            Center(
              child: Container(
                width: (Responsive.isDesktop(context)) ? 150 : 70,
                height: (Responsive.isDesktop(context)) ? 50 : 40,
                child: ElevatedButton(
                  // onPressed: _createMealObject,
                  onPressed: () {},
                  child: Text('Add',
                      style: TextStyle(
                        fontSize: (Responsive.isDesktop(context)) ? 35 : 15,
                      )),
                ),
              ),
            ),
          ],
        ),

*/

















// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_miniproject/module/edit_meal_screen_components/recipe_input.dart';
// import 'package:flutter_miniproject/module/edit_meal_screen_components/recipe_item.dart';
// import 'package:flutter_miniproject/provider/current_user_provider.dart';
// import 'package:flutter_miniproject/provider/recipe_provider.dart';
// import 'package:flutter_miniproject/provider/upload_image_provider.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_miniproject/model/meal.dart';
// import 'package:flutter_miniproject/model/screen_argument.dart';
// import 'package:flutter_miniproject/module/edit_meal_screen_components/mealpost_inputs_checker.dart';
// import 'package:flutter_miniproject/module/edit_meal_screen_components/customtextfield.dart';
// import 'package:flutter_miniproject/module/edit_meal_screen_components/invalid_dialog.dart';
// import 'package:flutter_miniproject/module/edit_meal_screen_components/post_delete_dialog.dart';
// import 'package:flutter_miniproject/responsive.dart';
// import 'package:flutter_miniproject/provider/meal_provider.dart';
// import 'package:flutter_miniproject/provider/const_provider.dart';
// import 'package:uuid/uuid.dart';
// import 'package:intl/intl.dart';

// class CreateMealPage extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
//     String _initialname = '';
//     String? _initialimage;
//     Uuid uuid = Uuid();
//     final constants = useProvider(constantsProvider);

//     final _namecontroller = useTextEditingController(text: _initialname);
//     final _recipeTextController = useTextEditingController();
//     final _byteimage = useState<Uint8List?>(null);
//     final _mealProvider = useProvider(mealProvider);
//     final _recipeProvider = useProvider(recipeProvider);
//     //final _user = useProvider(currentUserProvider);
//     //final _uploadimage = useProvider(uploadImageProvider);
//     final double _height = MediaQuery.of(context).size.height;
//     FilePickerResult? file;
//     //late String? _image;

//     /*
//     _createMealObject() async {
//       bool status = MealPostChecker.isComplete(
//           id: '1',
//           name: _namecontroller.text,
//           ingredients: _recipeProvider.ingredients,
//           image: _byteimage.value);

//       // bool status = MealPostChecker.isComplete(meal);
//       if (status) {
//         _image =
//             await _uploadimage.uploadFile(file: file, image: _byteimage.value);
//         final meal = Meal(
//             name: _namecontroller.text,
//             image: _image,
//             mealType: ['breakfast'],
//             ingredients: _recipeProvider.ingredients);

//         // _recipeProvider.deletePrevList();
//         _mealProvider.addMeals(
//             newMeal: meal.toJson(),
//             user_id: _user.user!.id!,
//             access_token: _user.user!.access_token!);
//         _namecontroller.clear();
//         _image = null;
//         _recipeTextController.clear();
//         showConfirmationDialog(context, 'Your meal is successfully uploaded.');
//       } else {
//         showInvalidDialog(context);
//       }
//     }
// */

//     //Sauce: https://github.com/miguelpruivo/flutter_file_picker/wiki/API#-getdirectorypath
//     Future _pickImage() async {
//       //use filepicker rather than ImagePickerWeb. Lang kwenta yung ayaw magsupport ng sdk 2.12.0
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//           type: FileType.custom, allowedExtensions: ['png', 'jpeg', 'jpg']);

//       if (result != null) {
//         //file = result;
//         _byteimage.value = result.files.first.bytes;
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(
//           color: Colors.black, //change your color here
//         ),
//         elevation: 0,
//       ),
//       body: Container(
//         padding: EdgeInsets.fromLTRB(
//             constants.kDefaultPadding * 2.5,
//             constants.kDefaultPadding,
//             constants.kDefaultPadding * 2.5,
//             constants.kDefaultPadding),
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: ListView(
//           children: [
//             if (args.meal == null)
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Text(
//                   'ADD A MEAL',
//                   style: GoogleFonts.dancingScript(
//                       color: Colors.black,
//                       fontSize: (Responsive.isDesktop(context))
//                           ? 48
//                           : (Responsive.isTablet(context))
//                               ? 38
//                               : 30),
//                   textAlign: TextAlign.center,
//                 ),
//               ),

//             //TODO: should i remove this box, or need ba to pag naupload na yung pic kasi di na null?
// /*
//             if (_byteimage.value != null)
//               Container(
//                 width: double.infinity,
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: IconButton(
//                       icon: FaIcon(
//                         FontAwesomeIcons.windowClose,
//                         size: _height * .03,
//                         color: Colors.black,
//                       ),
//                       onPressed: () {
//                         _byteimage.value = null;
//                       }),
//                 ),
//               ),
//             Padding(
//               padding: EdgeInsets.all(constants.kDefaultPadding - 10),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(17.0),
//                 child: AspectRatio(
//                   aspectRatio: 1.3,
//                   child: Container(
//                     width: double.infinity,
//                     //height: _height * .7,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                     ),
//                     //TODO: should i remove this box, or need ba to pag naupload na yung pic kasi di na null?
//                     child: (_byteimage.value != null)
//                         ? FittedBox(
//                             fit: BoxFit.cover,
//                             child: Image.memory(_byteimage.value!),
//                           )
//                         : IconButton(
//                             onPressed: _pickImage,
//                             icon: FaIcon(
//                               FontAwesomeIcons.image,
//                               size: _height * .08,
//                               color: Colors.red,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//             ),
//             */

//             Padding(
//               padding: EdgeInsets.all(constants.kDefaultPadding),
//               child: CustomTextField(
//                 controller: _namecontroller,
//                 fontsize: Responsive.isDesktop(context) ? 32 : 24,
//                 labelText: 'Meal Title',
//                 fontweight: FontWeight.w600,
//                 height: 1.3,
//               ),
//             ),

//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   RecipeInput(
//                     textController: _recipeTextController,
//                   ),
//                   FloatingActionButton(
//                     onPressed: () {
//                       _recipeProvider.addIngredient(
//                           body: _recipeTextController.text);
//                       _recipeTextController.clear();
//                     },
//                     child: Icon(Icons.add),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 150,
//               child: ListView.builder(
//                 itemBuilder: (context, i) {
//                   final recipe = _recipeProvider.ingredients[i];
//                   return RecipeListItem(
//                     ingredient: recipe,
//                   );
//                 },
//                 itemCount: _recipeProvider.ingredients.length,
//               ),
//             ),

//             /*
//             Center(
//               child: Container(
//                 width: (Responsive.isDesktop(context)) ? 150 : 70,
//                 height: (Responsive.isDesktop(context)) ? 50 : 40,
//                 child: ElevatedButton(
//                   onPressed: _createMealObject,
//                   child: Text('Add',
//                       style: TextStyle(
//                         fontSize: (Responsive.isDesktop(context)) ? 35 : 15,
//                       )),
//                 ),
//               ),
//             ),
//             */
//           ],
//         ),
//       ),
//     );
//   }
// }








































