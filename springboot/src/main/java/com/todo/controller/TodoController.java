package com.todo.controller;

import com.todo.entity.Todo;
import com.todo.repository.TodoRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/todos")
public class TodoController {

    private final TodoRepository todoRepository;

    public TodoController(TodoRepository todoRepository) {
        this.todoRepository = todoRepository;
    }

    @GetMapping
    public Map<String, List<Todo>> getList() {
        List<Todo> todos = todoRepository.findAllByOrderByCreatedAtDesc();
        Map<String, List<Todo>> result = new HashMap<>();
        result.put("list", todos);
        return result;
    }

    @PostMapping
    public ResponseEntity<Todo> add(@RequestBody Map<String, Object> body) {
        Todo todo = new Todo();
        todo.setValue((String) body.get("value"));
        todo.setIsCompleted(body.containsKey("isCompleted") ? (Boolean) body.get("isCompleted") : false);
        todoRepository.save(todo);
        return ResponseEntity.ok(todo);
    }

    @PostMapping("/{id}/toggle")
    public ResponseEntity<Void> update(@PathVariable Long id) {
        Todo todo = todoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Todo not found: " + id));
        todo.setIsCompleted(!todo.getIsCompleted());
        todoRepository.save(todo);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        todoRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }
}
