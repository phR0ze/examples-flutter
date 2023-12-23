// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class MovieScroller extends StatefulWidget {
  const MovieScroller(
      {Key? key, required this.title, required this.builder, this.onNextPageRequested})
      : super(key: key);
  final String title;
  final Function(BuildContext, ScrollController) builder;
  final VoidCallback? onNextPageRequested;

  @override
  _MovieScrollerState createState() => _MovieScrollerState();
}

class _MovieScrollerState extends State<MovieScroller> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      widget.onNextPageRequested?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widget.builder(context, _scrollController),
      backgroundColor: Colors.black,
    );
  }
}
