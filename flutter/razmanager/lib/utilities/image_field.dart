import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ImageField extends StatelessWidget {
  const ImageField({super.key, required FormGroup formGroup})
      : _formGroup = formGroup;

  final FormGroup _formGroup;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      final picker = ImagePicker();
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Image', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 16),
        if (_formGroup.control('image').value != null)
          Image.memory(_formGroup.control('image').value),
        const SizedBox(height: 16),
        Row(
          children: [
            FilledButton.tonal(
                child: const Text('Select an image'),
                onPressed: () async {
                  final xFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (xFile != null) {
                    _formGroup.control('image').value =
                        await xFile.readAsBytes();
                    setState(() {
                      _formGroup.control('image').markAsDirty();
                      _formGroup.control('imageDeleted').value = false;
                    });
                  }
                }),
            if (picker.supportsImageSource(ImageSource.camera)) ...[
              const SizedBox(width: 16),
              FilledButton.tonal(
                  child: const Text('Take photo'),
                  onPressed: () async {
                    final xFile =
                        await picker.pickImage(source: ImageSource.camera);
                    if (xFile != null) {
                      _formGroup.control('image').value =
                          await xFile.readAsBytes();
                      setState(() {
                        _formGroup.control('image').markAsDirty();
                        _formGroup.control('imageDeleted').value = false;
                      });
                    }
                  }),
            ],
            const SizedBox(width: 16),
            FilledButton.tonal(
              onPressed: _formGroup.control('image').value != null
                  ? () {
                      setState(() {
                        _formGroup.control('image').value = null;
                        _formGroup.control('imageDeleted').value = true;
                        _formGroup.control('imageDeleted').markAsDirty();
                      });
                    }
                  : null,
              child: const Text('Delete image'),
            ),
          ],
        ),
      ]);
    });
  }
}
