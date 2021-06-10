package com.nextit.free.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.nextit.board.vo.BoardVO;

@Mapper
public interface BoardDao {

	public List<BoardVO> getBoardList(); 
	public BoardVO getBoard(int boNo) ;
	public int increaseHit(int boNo);
	public int updateBoard(BoardVO board);
	public int deleteBoard(BoardVO board);
	public int insertBoard(BoardVO board);
}