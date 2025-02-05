package kr.or.ddit.projects.todoList.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.projects.vo.TodoListVO;

@Mapper
public interface TodoListMapper {
	
	public List<TodoListVO> selectTodoListList(@Param("pjMemId") String pjMemId, @Param("pjId") String pjId);
	
	public TodoListVO selectTodoList(String todoId);
	
	public int updateTodoList(TodoListVO todoList);
	
	public int insertTodoList(TodoListVO todoList);
	
	public int deleteTodoList(String todoId);
}
