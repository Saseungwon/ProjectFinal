package com.nextit.free.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.nextit.board.vo.BoardVO;
import com.nextit.exception.BizNotEffectedException;
import com.nextit.exception.BizNotFoundException;
import com.nextit.free.service.BoardDao;
import com.nextit.free.service.BoardService;

@Service
public class BoardServiceImp implements BoardService{

	@Inject
	BoardDao boardDao;
	
	@Override
	public List<BoardVO> getBoardList() {
		return boardDao.getBoardList();
	}
	
	@Override
	public BoardVO getBoard(int boNo) throws BizNotFoundException {
		BoardVO board = boardDao.getBoard(boNo);
		if (board == null) {
			throw new BizNotFoundException();
		}
		return board;
	}
	
	@Override
	public void increaseHit(int boNo) throws BizNotEffectedException {
		int cnt = boardDao.increaseHit(boNo);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
	}
	
	@Override
	public void modifyBoard(BoardVO free)
			throws BizNotFoundException, BizNotEffectedException{
		BoardVO board = boardDao.getBoard(free.getBoNo());
		System.out.println(board);
		if (board == null) {
			throw new BizNotFoundException();
		}else {
			int cnt = boardDao.updateBoard(free);
			System.out.println(cnt);
			if (cnt < 1)
				throw new BizNotEffectedException();
		}
	}
	
	@Override
	public void removeBoard(BoardVO free)
		throws BizNotFoundException, BizNotEffectedException {
		BoardVO board = boardDao.getBoard(free.getBoNo());
		if (board == null)
			throw new BizNotFoundException();
		else {
			int cnt = boardDao.deleteBoard(free);
			if(cnt < 1)
				throw new BizNotEffectedException();
		}
	}
	
	@Override
	public void registBoard(BoardVO free) throws BizNotEffectedException {
		boardDao.insertBoard(free);
	}
	
	
}
	
