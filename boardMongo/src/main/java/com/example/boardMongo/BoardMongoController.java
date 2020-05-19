package com.example.boardMongo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardMongoController {
	// 루트인덱스 지정. 해주지 않으면 기본적으로 static 아래의 index.html로 간다.
	@RequestMapping("/")
	    public String index() throws Exception {
	        return "/index";
	    }  
	
	@RequestMapping("/board.do")
	    public String board() throws Exception {
	        return "/board";
	    } 
}
