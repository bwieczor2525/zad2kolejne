import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditScreen extends StatefulWidget {
  final Task? task;

  const EditScreen({Key? key, this.task}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedFont = 'Arial';
  double _fontSize = 16;
  String _tileColor = '0xFFFFFFFF'; // Default color: white
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _contentController.text = widget.task!.content;
      _selectedFont = widget.task!.font;
      _fontSize = widget.task!.fontSize;
      _tileColor = widget.task!.color;
      _isCompleted = widget.task!.isCompleted == 1; // Convert to boolean
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context, listen: false).currentUser!.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Edycja zadania')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Tytuł'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Zawartość'),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedFont,
              items: const [
                DropdownMenuItem(value: 'Arial', child: Text('Arial')),
                DropdownMenuItem(value: 'Times New Roman', child: Text('Times New Roman')),
                DropdownMenuItem(value: 'Roboto', child: Text('Roboto')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFont = value!;
                });
              },
              isExpanded: true,
              hint: const Text('Wybierz czcionkę'),
            ),
            Slider(
              value: _fontSize,
              min: 8,
              max: 26,
              divisions: 18,
              label: _fontSize.toString(),
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ukończone zadanie'),
                Switch(
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final color = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Wybierz kolor kafelka'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: Color(int.parse(_tileColor)),
                        onColorChanged: (color) {
                          Navigator.pop(context, color.value.toRadixString(16));
                        },
                      ),
                    ),
                  ),
                );
                if (color != null) {
                  setState(() {
                    _tileColor = '0x$color';
                  });
                }
              },
              child: const Text('Wybierz kolor kafelka'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final task = Task(
                  id: widget.task?.id ?? 0,
                  title: _titleController.text.trim(),
                  content: _contentController.text.trim(),
                  font: _selectedFont,
                  fontSize: _fontSize,
                  color: _tileColor,
                  isCompleted: _isCompleted ? 1 : 0, // Convert to integer
                  userId: userId,
                );
                if (widget.task == null) {
                  Provider.of<TaskProvider>(context, listen: false).addTask(task);
                } else {
                  Provider.of<TaskProvider>(context, listen: false).updateTask(task);
                }
                Navigator.pop(context);
              },
              child: const Text('Zapisz zadanie'),
            ),
          ],
        ),
      ),
    );
  }
}
