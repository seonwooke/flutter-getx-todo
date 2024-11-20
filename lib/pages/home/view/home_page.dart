import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../pages.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      title: const Text(
        'GETX TODO APP',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _todoTextFieldSection(),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _todoListSection(),
        ],
      ),
    );
  }

  Widget _todoTextFieldSection() {
    return Row(
      children: [
        /// Text Field
        Expanded(
          child: TextField(
            controller: textController,
            cursorColor: Colors.black,
            autofocus: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: 'TODO 입력',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 16),

        /// Add Button
        InkWell(
          onTap: () {
            if (textController.text.isEmpty) {
              Get.snackbar('🚨', 'TODO를 입력해주세요.');
            } else {
              controller.addTodo(textController.text);
              textController.clear();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'ADD',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _todoListSection() {
    return Expanded(
      child: Obx(() {
        return controller.todos.isEmpty
            ? const Center(
                child: Text(
                  '아직 작성된 TODO가 없습니다.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: controller.todos.length,
                itemBuilder: (context, index) {
                  return _todoItemView(index);
                },
              );
      }),
    );
  }

  Widget _todoItemView(int index) {
    final todo = controller.todos[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Check Box & Todo Contents
          Row(
            children: [
              /// Check Box
              Checkbox(
                value: todo.isDone,
                activeColor: Colors.black,
                onChanged: (value) => controller.toggleTodoStatus(index),
              ),
              const SizedBox(width: 16),

              /// Todo Contents
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.todo,
                    style: TextStyle(
                      decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: todo.isDone ? Colors.grey : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('yyyy년 MM월 dd일 hh시 mm분')
                        .format(todo.createdTime),
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          ),

          /// Delete Button
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              controller.removeTodoAt(index);
            },
          ),
        ],
      ),
    );

    // ListTile(
    //   leading: Checkbox(
    //     value: todo.isDone,
    //     onChanged: (value) => controller.toggleTodoStatus(index),
    //   ),
    //   title: Text(
    //     todo.todo,
    //     style: TextStyle(
    //       decoration:
    //           todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
    //       color: todo.isDone ? Colors.grey : Colors.black,
    //     ),
    //   ),
    //   subtitle: Text(
    //     'Created: ${todo.createdTime.toLocal()}',
    //     style: const TextStyle(fontSize: 12),
    //   ),
    //   trailing: IconButton(
    //     icon: const Icon(Icons.delete, color: Colors.red),
    //     onPressed: () {
    //       controller.removeTodoAt(index);
    //     },
    //   ),
    // );
  }
}
