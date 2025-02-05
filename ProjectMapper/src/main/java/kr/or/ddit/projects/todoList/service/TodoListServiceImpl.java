package kr.or.ddit.projects.todoList.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.todoList.mapper.TodoListMapper;
import kr.or.ddit.projects.vo.TodoListVO;

@Service
public class TodoListServiceImpl implements TodoListService {
	
	@Autowired
	private TodoListMapper mapper;

	@Override
	public List<TodoListVO> readTodoListList(String pjMemId, String pjId) {
		return mapper.selectTodoListList(pjMemId, pjId);
	}

	@Override
	public TodoListVO readTodoList(String todoId) {
		return mapper.selectTodoList(todoId);
	}

	@Override
	public ServiceResult modifyTodoList(TodoListVO todoList) {
		return mapper.updateTodoList(todoList)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult createTodoList(TodoListVO todoList) {
		String todoEndDate = todoList.getTodoEndDate().toString().replace("-", "");
		todoList.setTodoEndDate(todoEndDate);
		
		return mapper.insertTodoList(todoList)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeTodoList(String todoId) {
		return mapper.deleteTodoList(todoId)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
