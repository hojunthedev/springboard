package com.example.boardMongo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BoardMongoController {
	
	@Autowired
	private Environment env;	//application.property 에서 선언된 값들을 읽어올 수 있음.
	
	@Autowired
	private MongoTemplate mongoTemplate;
	
	@Autowired
	private BoardRepository boardRepository;
	
	// 루트인덱스 지정. 해주지 않으면 기본적으로 static 아래의 index.html로 간다.
	@RequestMapping("/")
	    public String index() throws Exception {
	        return "/index";
	    }  
	
	@RequestMapping("/board.do")
	    public String board() throws Exception {
		return "/board";
	    } 
	
	@RequestMapping("/list.do")
    @ResponseBody
	public Map<String, Object> list() throws Exception {
		Map<String, Object> map = new HashMap<>();
		List<Board> list = new ArrayList<Board>();
		
		//모든 정보 조회
		list = boardRepository.findAll();
		
		map. put("list", list);
		return map;
    } 
}
