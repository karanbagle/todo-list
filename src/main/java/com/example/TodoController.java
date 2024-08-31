package com.example;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/todos")
public class TodoController {

    @Autowired
    private TodoItemRepository todoItemRepository;

    @GetMapping
    public List<TodoItem> getAllTodos() {
        return todoItemRepository.findAll();
    }

    @PostMapping
    public TodoItem addTodo(@RequestBody TodoItem todoItem) {
        return todoItemRepository.save(todoItem);
    }

    @PutMapping("/{id}")
    public TodoItem updateTodo(@PathVariable Long id, @RequestBody TodoItem updatedTodoItem) {
        TodoItem todoItem = todoItemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Todo not found"));
        todoItem.setCompleted(updatedTodoItem.isCompleted());
        return todoItemRepository.save(todoItem);
    }

    @DeleteMapping("/{id}")
    public void deleteTodo(@PathVariable Long id) {
        todoItemRepository.deleteById(id);
    }
}
