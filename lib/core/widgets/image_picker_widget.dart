import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ribaru_v2/core/services/image_service.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';

class ImagePickerWidget extends StatefulWidget {
  final String? initialImagePath;
  final Function(String?) onImageSelected;
  final String directory;
  final String prefix;
  final double size;
  final bool circular;

  const ImagePickerWidget({
    super.key,
    this.initialImagePath,
    required this.onImageSelected,
    required this.directory,
    required this.prefix,
    this.size = 150,
    this.circular = false,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImageService _imageService = ImageService();
  String? _imagePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.initialImagePath;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() => _isLoading = true);

      // Delete old image if exists
      if (_imagePath != null) {
        await _imageService.deleteImage(_imagePath!);
      }

      final String? newImagePath = await _imageService.pickAndSaveImage(
        directory: widget.directory,
        prefix: widget.prefix,
        source: source,
      );

      setState(() => _imagePath = newImagePath);
      widget.onImageSelected(newImagePath);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildImagePreview() {
    if (_isLoading) {
      return Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(widget.circular ? widget.size : 8),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_imagePath != null) {
      return Stack(
        children: [
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.circular ? widget.size : 8),
              image: DecorationImage(
                image: FileImage(File(_imagePath!)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () async {
                  if (_imagePath != null) {
                    await _imageService.deleteImage(_imagePath!);
                    setState(() => _imagePath = null);
                    widget.onImageSelected(null);
                  }
                },
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(widget.circular ? widget.size : 8),
      ),
      child: Icon(
        Icons.add_a_photo,
        size: widget.size * 0.3,
        color: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Take a photo'),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Choose from gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: _buildImagePreview(),
    );
  }
}
