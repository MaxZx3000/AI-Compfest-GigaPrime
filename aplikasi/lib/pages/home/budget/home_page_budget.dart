import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travelling_app/pages/home/budget/travelling_place_fetch_budget_options_widget.dart';
import 'package:travelling_app/pages/home/budget/travelling_place_result_widget_budget.dart';

class HomeBudgetPage extends StatefulWidget{

  const HomeBudgetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeBudgetPageState();
  }
}

class _HomeBudgetPageState extends State<HomeBudgetPage>{

  late TravellingPlaceFetchBudgetOptionsWidget travellingPlaceFetchOptionsWidget;
  late TravellingPlacesWidgetBudget travellingPlacesWidgetBudget;

  @override
  void initState() {
    super.initState();
    travellingPlacesWidgetBudget = TravellingPlacesWidgetBudget();
    travellingPlaceFetchOptionsWidget = TravellingPlaceFetchBudgetOptionsWidget(
        onSearchClick: (
            // Map<String, bool> checkboxesCitiesValue,
            // Map<String, bool> checkboxesCategoriesValue,
            String city,
            String category,
            int ticketPrice,
            ){
          String city = travellingPlaceFetchOptionsWidget.cityValue;
          String category = travellingPlaceFetchOptionsWidget.categoryValue;

          print("City Query: $city.");
          print("Category Query: $category");

          travellingPlacesWidgetBudget.performSearch(
              ticketPrice,
              city,
              category
          );
          FocusManager.instance.primaryFocus?.unfocus();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
            ),
            child: Center(
                child: travellingPlacesWidgetBudget
            ),
          ),
          travellingPlaceFetchOptionsWidget,
        ],
      ),
    );
  }
}