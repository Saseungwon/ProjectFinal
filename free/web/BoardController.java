package com.nextit.free.web;

import java.util.List;

import javax.inject.Inject;
import javax.validation.groups.Default;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.nextit.board.vo.BoardVO;
import com.nextit.common.valid.ModifyType;
import com.nextit.common.valid.RegistType;
import com.nextit.common.vo.ResultMessageVO;
import com.nextit.exception.BizNotEffectedException;
import com.nextit.exception.BizNotFoundException;
import com.nextit.exception.BizPasswordNotMatchedException;
import com.nextit.free.service.BoardService;

@Controller
public class BoardController {
	
	@Inject
	BoardService boardService; 
	
	@RequestMapping("/free/boardList.wow")
	public String BoardList(Model model) {
		List<BoardVO> boardList= boardService.getBoardList();
		model.addAttribute("boardList", boardList);
		return "free/boardList";
	}
	
	@RequestMapping("/free/boardView.wow")
	public String boardView(@RequestParam(value = "boNo", required = true) int boNo, Model model) {
		try {
		BoardVO board = boardService.getBoard(boNo);
		model.addAttribute("board", board);
		} catch (BizNotFoundException e) {
			ResultMessageVO resultMessageVO = new ResultMessageVO();
			resultMessageVO.setMessage("글을 찾을 수 없거나 조회수 증가 실패.");
			resultMessageVO.setResult(false);
			resultMessageVO.setTitle("view");
			resultMessageVO.setUrl("boardList.wow");
			resultMessageVO.setUrlTitle("목록으로");
			model.addAttribute("resultMessageVO", resultMessageVO);
			return "common/message";
	}
		return "free/boardView"; 
		
	}
	
	@RequestMapping("/free/boardEdit.wow")
	public String boardEdit(@RequestParam int boNo, Model model) {
		BoardVO board = null;
		try {
			board = boardService.getBoard(boNo); 
		}catch(BizNotFoundException e) {
			ResultMessageVO resultMessageVO = new ResultMessageVO();
			resultMessageVO.setMessage("글을 찾을 수 없습니다.");
			resultMessageVO.setResult(false);
			resultMessageVO.setTitle("edit");
			resultMessageVO.setUrl("freeList.wow");
			resultMessageVO.setUrlTitle("목록으로");
			model.addAttribute("resultMessageVO", resultMessageVO);
			return "common/message";
		}
		model.addAttribute("board", board);
		return "free/boardEdit";
			
		}
	
	@PostMapping("/free/boardModify.wow")
	public ModelAndView boardModify(@ModelAttribute("board")
	@Validated({Default.class,ModifyType.class})
	BoardVO board,BindingResult error) {
		ModelAndView mav = new ModelAndView();
		if(error.hasErrors()) {
			mav.setViewName("free/boardEdit");
			return mav;
		}
		ResultMessageVO resultMessageVO = new ResultMessageVO();
		try {
			boardService.modifyBoard(board);
			resultMessageVO.setMessage("정상적으로 수정했습니다.");
			resultMessageVO.setResult(true);
			resultMessageVO.setTitle("수정");
			resultMessageVO.setUrl("boardView.wow?boNo=" + board.getBoNo());
			resultMessageVO.setUrlTitle("뷰화면으로 ");
		} catch (BizNotFoundException e) {
			resultMessageVO.setMessage("비밀번호가 다릅니다");
			resultMessageVO.setResult(false);
			resultMessageVO.setTitle("수정");
			resultMessageVO.setUrl("boardView.wow?boNo=" + board.getBoNo());
			resultMessageVO.setUrlTitle("뷰화면으로");
			e.printStackTrace();
		} catch (BizPasswordNotMatchedException e) {
			resultMessageVO.setMessage("수정실패");
			resultMessageVO.setResult(false);
			resultMessageVO.setTitle("수정");
			resultMessageVO.setUrl("boardView.wow?boNo=" + board.getBoNo());
			resultMessageVO.setUrlTitle("뷰화면으로");
			e.printStackTrace();
		} catch (BizNotEffectedException e) {
			resultMessageVO.setMessage("찾을 수 없습니다");
			resultMessageVO.setResult(false);
			resultMessageVO.setTitle("수정");
			resultMessageVO.setUrl("boardView.wow?boNo=" + board.getBoNo());
			resultMessageVO.setUrlTitle("뷰화면으로");
			e.printStackTrace();
		}
		mav.addObject("resultMessageVO", resultMessageVO);
		mav.setViewName("redirect:/free/boardView.wow?boNo=" +  board.getBoNo());
		return mav;
		
	}
	
	@PostMapping(value="/free/boardDelete.wow")
	public String boardDelete(Model model,
		@ModelAttribute("board")@Validated({Default.class,ModifyType.class})
		BoardVO board,BindingResult error) {
			if(error.hasErrors()) {
				return "free/boardEdit";
			}
		ResultMessageVO resultMessageVO = new ResultMessageVO();
		
		try{
			boardService.removeBoard(board);
			resultMessageVO.setResult(true);
			resultMessageVO.setTitle("delete");
			resultMessageVO.setMessage("정상적으로 삭제했습니다.");
			resultMessageVO.setUrl("boardList.wow");
			resultMessageVO.setUrlTitle("목록으로");
		}catch (BizPasswordNotMatchedException bizPasswordNotMatchedException){
			resultMessageVO.setResult(false);
			resultMessageVO.setTitle("delete");
			resultMessageVO.setMessage("비밀번호가 틀립니다.");
			resultMessageVO.setUrl("boardList.wow");
			resultMessageVO.setUrlTitle("목록으로");
		}catch(BizNotEffectedException bizNotEffectedException){
			resultMessageVO.setResult(false);
			resultMessageVO.setTitle("delete");
			resultMessageVO.setMessage("삭제 실패");
			resultMessageVO.setUrl("boardList.wow");
			resultMessageVO.setUrlTitle("목록으로");
		}catch(BizNotFoundException bizNotFoundException){
			resultMessageVO.setResult(false);
			resultMessageVO.setTitle("delete");
			resultMessageVO.setMessage("해당 글이 존재하지 않습니다.");
			resultMessageVO.setUrl("boardList.wow");
			resultMessageVO.setUrlTitle("목록으로");
		}
		model.addAttribute("resultMessageVO", resultMessageVO);
		
		return "common/message";
	
	}
	
	
	
	@RequestMapping(value="/free/boardRegist.wow")
	public String freeForm(@ModelAttribute("free")BoardVO free, Model model) {
		return "free/boardForm";
	}
	
	
	@PostMapping(value="/free/boardRegist.wow")
	public String freeRegist(@ModelAttribute("board")@Validated({Default.class, RegistType.class}) BoardVO board,
			BindingResult errors,
			Model model) {
		if (errors.hasErrors()) {
			return "free/boardForm";
		}
		ResultMessageVO resultMessageVO = new ResultMessageVO();
		
		try{
			boardService.registBoard(board);
			resultMessageVO.setResult(true);
			resultMessageVO.setTitle("regist");
			resultMessageVO.setMessage("정상적으로 글이 되었습니다.");
			resultMessageVO.setUrl("boardList.wow");
			resultMessageVO.setUrlTitle("목록으로");
		}catch(BizNotEffectedException e){
			resultMessageVO.setResult(false);
			resultMessageVO.setTitle("regist");
			resultMessageVO.setMessage("글 등록 실패");
			resultMessageVO.setUrl("boardList.wow");
			resultMessageVO.setUrlTitle("목록으로");
		}
		model.addAttribute("resultMessageVO", resultMessageVO);
		
		return "common/message";
	}
}
	
	
	
	

