package kr.or.ddit.projects.todoList.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.TodoListVO;

public interface TodoListService {
	
	public List<TodoListVO> readTodoListList(String pjMemId, String pjId);
	
	public TodoListVO readTodoList(String todoId);
	
	public ServiceResult modifyTodoList(TodoListVO todoList);
	
	public ServiceResult createTodoList(TodoListVO todoList);
	
	public ServiceResult removeTodoList(String todoId);
}
