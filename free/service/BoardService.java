package com.nextit.free.service;

import java.util.List;

import com.nextit.board.vo.BoardVO;
import com.nextit.exception.BizNotEffectedException;
import com.nextit.exception.BizNotFoundException;
import com.nextit.exception.BizPasswordNotMatchedException;

public interface BoardService {

	public List<BoardVO> getBoardList(); 
	public BoardVO getBoard(int boNo) throws BizNotFoundException;
	public void increaseHit(int boNo) throws BizNotEffectedException;
	public void modifyBoard(BoardVO board) throws BizNotFoundException, BizPasswordNotMatchedException, BizNotEffectedException;	
	public void removeBoard(BoardVO board) throws BizNotFoundException, BizPasswordNotMatchedException, BizNotEffectedException; 	
	public void registBoard(BoardVO board) throws BizNotEffectedException;	
	
}