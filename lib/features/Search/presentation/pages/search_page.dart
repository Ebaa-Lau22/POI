import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/app_cubit/state_builder.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/Search/data/enum/filter_enum.dart';
import 'package:poi/features/Search/presentation/bloc/search_cubit.dart';
import 'package:poi/features/Search/presentation/bloc/search_states.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          context.read<SearchCubit>().onSearchQueryChanged(
                            value,
                          );
                        },
                        controller:
                            context.read<SearchCubit>().searchController,
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
                          context.read<SearchCubit>().onSearchQueryChanged(
                            context.read<SearchCubit>().searchController.text,
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
                      FilterEnum.values.map((filter) {
                        return StateBuilder(
                          cubit: context.read<SearchCubit>().selectedFilter,
                          builder: (selectedFilter) {
                            return GestureDetector(
                              onTap: () {
                                context.read<SearchCubit>().onFilterChanged(
                                  filter,
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      selectedFilter == filter
                                          ? AppColors.darkBlue
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.darkBlue,
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  filter.name,
                                  style: TextStyle(
                                    color:
                                        selectedFilter == filter
                                            ? Colors.white
                                            : AppColors.darkBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                ),

                Expanded(
                  child: StateBuilder(
                    cubit: context.read<SearchCubit>().selectedFilter,
                    builder: (selectedFilter) {
                      switch (selectedFilter) {
                        case FilterEnum.people:
                          return _buildPeopleList();
                        case FilterEnum.debates:
                          return _buildDebatesList();
                      }
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

  Widget _buildPeopleList() {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, state) {
        if (state is SearchGetUsersSuccessState) {
          if (state.usersData.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          return ListView.builder(
            itemCount: state.usersData.length,
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
                        child: Text(state.usersData[index].firstName[0]),
                      ),
                      title: Text(state.usersData[index].firstName),
                      subtitle: Text(state.usersData[index].email),
                      onTap: () {},
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is SearchGetUsersLoadingState) {
          final color = ThemedColors(context.read<AppCubit>().isLightTheme);
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: color.blue,
              secondRingColor: color.red,
              thirdRingColor: color.primary,
              size: 35,
            ),
          );
        } else if (state is SearchGetUsersErrorState) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }

  // Todo debate card
  Widget _buildDebatesList() {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, state) {
        if (state is SearchGetFinishedDebatesSuccessState) {
          if (state.finishedDebatesData.isEmpty) {
            return const Center(child: Text('No finished debates found'));
          }
          return ListView.builder(
            itemCount: state.finishedDebatesData.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 80,
                child: Card(
                  color: AppColors.lighterColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          );
        } else if (state is SearchGetFinishedDebatesLoadingState) {
          final color = ThemedColors(context.read<AppCubit>().isLightTheme);
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: color.blue,
              secondRingColor: color.red,
              thirdRingColor: color.primary,
              size: 35,
            ),
          );
        } else if (state is SearchGetFinishedDebatesErrorState) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
