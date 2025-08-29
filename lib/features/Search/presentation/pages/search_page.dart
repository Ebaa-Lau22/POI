import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/theme/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String selectedFilter = "People";

  final List<String> filters = ["People", "Debates"];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final appCubit = context.read<AppCubit>();
        final color = ThemedColors(appCubit.isLightTheme);
        final textStyle = Theme.of(context).textTheme;
        return Scaffold(
          backgroundColor: const Color.fromRGBO(234, 237, 243, 1),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 80),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search here...',
                          hintStyle: const TextStyle(
                            color: AppColors.darkBlue,
                            fontFamily: "Sansation",
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Material(
                      color: AppColors.darkBlue,
                      borderRadius: BorderRadius.circular(24),
                      child: InkWell(
                        onTap: () {
                          print(
                            'Searching for: ${searchController.text} in $selectedFilter',
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.search,
                            color: AppColors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ====== Filters as Containers ======
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                      filters.map((filter) {
                        bool isSelected = filter == selectedFilter;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.darkBlue
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.darkBlue,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              filter,
                              style: TextStyle(
                                color:
                                    isSelected
                                        ? Colors.white
                                        : AppColors.darkBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),

                // ====== Results Section ======
                SizedBox(
                  height: 530,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 80,
                        child: Card(
                          color: AppColors.lighterColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.lightBlue,

                                child: Text(selectedFilter[0]), // P or D
                              ),
                              title: Text(
                                selectedFilter == "People"
                                    ? "Person ${index + 1}"
                                    : "Debate ${index + 1}",
                              ),
                              subtitle:
                                  selectedFilter == "Debates"
                                      ? const Text("Judge: Ahmad Ali")
                                      : null,
                              onTap: () {
                                print(
                                  "Tapped on ${selectedFilter == "People" ? "Person" : "Debate"} ${index + 1}",
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
