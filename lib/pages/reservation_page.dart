import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/reservation_data.dart';
import '../core/responsive.dart';
import '../core/salon_data.dart';
import '../widgets/reservation/reservation_widgets.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  ReservationMenu? _menu;
  String? _staff;
  DateTime? _date;
  String? _time;
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _displayedMonth = DateTime(now.year, now.month);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _goHome() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  String _formatDate(DateTime? date) => date == null
      ? '未選択'
      : '${date.year}年${date.month}月${date.day}日';

  Future<void> _confirm() async {
    final formIsValid = _formKey.currentState?.validate() ?? false;
    if (!formIsValid ||
        _menu == null ||
        _staff == null ||
        _date == null ||
        _time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('すべての必須項目を入力・選択してください。')),
      );
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.ivory,
        title: const Text('予約内容の確認'),
        content: Text(
          '${_menu!.name}\n$_staff\n${_formatDate(_date)}  $_time\n\n'
          '${_nameController.text} 様\n${_phoneController.text}\n'
          '${_emailController.text}',
          style: const TextStyle(height: 1.8),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('修正する'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('内容を確認しました'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.ivory.withValues(alpha: .96),
        surfaceTintColor: Colors.transparent,
        toolbarHeight: context.isMobile ? 72 : 88,
        titleSpacing: 0,
        title: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.maxContent,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.horizontalPadding,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: _goHome,
                    child: const Text(
                      SalonData.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2.2,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'RESERVATION',
                    style: TextStyle(fontSize: 11, letterSpacing: 2.2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                context.horizontalPadding,
                context.isMobile ? 54 : 88,
                context.horizontalPadding,
                100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ご予約',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'ご希望のメニュー・日時をお選びください。',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: context.isMobile ? 64 : 96),
                  ReservationStep(
                    number: '01',
                    title: 'メニューを選択',
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.isMobile ? 1 : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 150,
                      ),
                      itemCount: ReservationData.menus.length,
                      itemBuilder: (context, index) {
                        final menu = ReservationData.menus[index];
                        return MenuChoiceCard(
                          menu: menu,
                          selected: _menu == menu,
                          onTap: () => setState(() => _menu = menu),
                        );
                      },
                    ),
                  ),
                  ReservationStep(
                    number: '02',
                    title: 'スタッフを選択',
                    child: _ChoiceWrap(
                      values: ReservationData.staff,
                      selected: _staff,
                      onSelected: (value) => setState(() => _staff = value),
                    ),
                  ),
                  ReservationStep(
                    number: '03',
                    title: '日付を選択',
                    child: ReservationCalendar(
                      displayedMonth: _displayedMonth,
                      selectedDate: _date,
                      onDateSelected: (date) => setState(() => _date = date),
                      onPreviousMonth: _displayedMonth.year ==
                                  DateTime.now().year &&
                              _displayedMonth.month == DateTime.now().month
                          ? null
                          : () => setState(() {
                                _displayedMonth = DateTime(
                                  _displayedMonth.year,
                                  _displayedMonth.month - 1,
                                );
                              }),
                      onNextMonth: () => setState(() {
                        _displayedMonth = DateTime(
                          _displayedMonth.year,
                          _displayedMonth.month + 1,
                        );
                      }),
                    ),
                  ),
                  ReservationStep(
                    number: '04',
                    title: '時間を選択',
                    child: _ChoiceWrap(
                      values: ReservationData.times,
                      selected: _time,
                      onSelected: (value) => setState(() => _time = value),
                    ),
                  ),
                  ReservationStep(
                    number: '05',
                    title: 'お客様情報',
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _InputField(
                            label: 'お名前',
                            controller: _nameController,
                            isRequired: true,
                          ),
                          _InputField(
                            label: '電話番号',
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            isRequired: true,
                          ),
                          _InputField(
                            label: 'メールアドレス',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            isRequired: true,
                          ),
                          _InputField(
                            label: '備考',
                            controller: _notesController,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ReservationStep(
                    number: '06',
                    title: '予約内容確認',
                    child: _ReservationSummary(
                      menu: _menu?.name ?? '未選択',
                      staff: _staff ?? '未選択',
                      date: _formatDate(_date),
                      time: _time ?? '未選択',
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _confirm,
                      child: const Text('予約内容を確認する'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChoiceWrap extends StatelessWidget {
  const _ChoiceWrap({
    required this.values,
    required this.selected,
    required this.onSelected,
  });

  final List<String> values;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final value in values)
          SizedBox(
            width: context.isMobile ? 150 : 190,
            child: ChoiceButton(
              label: value,
              selected: selected == value,
              onPressed: () => onSelected(value),
            ),
          ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.isRequired = false,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: isRequired
            ? (value) => value == null || value.trim().isEmpty
                ? '入力してください'
                : null
            : null,
        decoration: InputDecoration(
          labelText: isRequired ? '$label *' : label,
          alignLabelWithHint: maxLines > 1,
          filled: true,
          fillColor: AppColors.white,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.charcoal, width: 1.5),
          ),
        ),
      ),
    );
  }
}

class _ReservationSummary extends StatelessWidget {
  const _ReservationSummary({
    required this.menu,
    required this.staff,
    required this.date,
    required this.time,
  });

  final String menu;
  final String staff;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.isMobile ? 24 : 34),
      decoration: BoxDecoration(
        color: AppColors.sand.withValues(alpha: .55),
        border: const Border(
          top: BorderSide(color: AppColors.charcoal),
          bottom: BorderSide(color: AppColors.charcoal),
        ),
      ),
      child: Column(
        children: [
          _SummaryRow(label: 'メニュー', value: menu),
          _SummaryRow(label: 'スタッフ', value: staff),
          _SummaryRow(label: '日付', value: date),
          _SummaryRow(label: '時間', value: time),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
