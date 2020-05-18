package com.example.boardMongo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardMongoController {
	 @RequestMapping("/board")
	    public String board() throws Exception {
	        return "board";
	    }
}
