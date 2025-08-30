import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:poi/core/app_models/new_profile_model.dart';
import 'package:poi/core/storage/preferences_database.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/di/injection_container.dart';
import 'package:poi/features/Debates/data/enums/judge_type.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/data/models/dto/send_request_from_judge_dto.dart';
import 'package:poi/features/Debates/domain/usecases/send_request_from_debater_use_case.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';

class AnnouncedDebateWidget extends StatefulWidget {
  const AnnouncedDebateWidget({
    super.key,
    required this.debate,
    required this.index,
  });

  final DebateData debate;
  final int index;

  @override
  State<AnnouncedDebateWidget> createState() => _AnnouncedDebateWidgetState();
}

class _AnnouncedDebateWidgetState extends State<AnnouncedDebateWidget> {
  String savedGuard = "";
  ProfileData? profile;

  @override
  void initState() {
    super.initState();
    getProfile();
    _loadGuard();
  }

  Future<void> getProfile() async {
    profile = await PreferencesDatabase().getProfileData();
  }

  Future<void> _loadGuard() async {
    final prefs = PreferencesDatabase();
    final value = await prefs.getEncryptedValue("Guard");
    if (!mounted) return;
    setState(() {
      savedGuard = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lighterColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child:
            //  Image.asset(
            //   "assets/images/debate.png",
            //   width: 100,
            //   height: 100,
            //   fit: BoxFit.cover,
            // ),
            Image.network(
              "https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 3),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.debate.type,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 18,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              DateFormat(
                                'dd-MM-yyyy',
                              ).format(widget.debate.startDate!.toLocal()),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 18,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              DateFormat('HH:mm').format(
                                DateFormat(
                                  'HH:mm:ss',
                                ).parse(widget.debate.startTime),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    (savedGuard == "debater")
                        ? Container(
                          decoration: BoxDecoration(
                            gradient:
                                widget.debate.isAbleToApply
                                    ? const LinearGradient(
                                      colors: [
                                        AppColors.darkRed,
                                        AppColors.darkBlue,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                    : null,
                            color:
                                widget.debate.isAbleToApply
                                    ? null
                                    : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                context.read<DebatesCubit>().toggleApply(
                                  index: widget.index,
                                  debateId: widget.debate.debateId,
                                  context: context,
                                );
                              },

                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: 60,
                                  height: 20,
                                  child: Center(
                                    child: Text(
                                      widget.debate.isAbleToApply
                                          ? 'Join'
                                          : 'Joined!',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Ubuntu',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 10),
                if (savedGuard == "judge") _buildJudgeButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJudgeButtons() {
    if (widget.debate.chairJudge != null &&
        widget.debate.chairJudge!.chairJudgeId == profile?.profile?.id) {
      return Text("Already Joined as chair judge");
    } else if (widget.debate.isJoinedAsChairJudge) {
      return Text("Request sent please wait");
    }
    if (widget.debate.panelistJudges.isNotEmpty &&
        widget.debate.panelistJudges.any(
          (e) =>
              e.id == profile?.profile?.id ||
              e.name ==
                  '${profile?.profile?.firstName} ${profile?.profile?.lastName}',
        )) {
      return Text("Already Joined as panelist judge");
    } else if (widget.debate.isJoinedAsPanelistJudge) {
      return Text("Request sent please wait");
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              context.read<DebatesCubit>().toggleJoinJudge(
                index: widget.index,
                context: context,
                request: SendRequestFromJudgeDto(
                  judgeType: JudgeType.chair,
                  debateid: widget.debate.debateId,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Join as Chair',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: () {
              context.read<DebatesCubit>().toggleJoinJudge(
                index: widget.index,
                context: context,
                request: SendRequestFromJudgeDto(
                  judgeType: JudgeType.panelist,
                  debateid: widget.debate.debateId,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Join as Panelist',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
