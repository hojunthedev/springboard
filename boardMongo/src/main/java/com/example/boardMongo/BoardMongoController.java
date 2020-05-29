package com.example.boardMongo;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
		System.out.println("list=========");
		Map<String, Object> map = new HashMap<>();
		List<Board> list = new ArrayList<Board>();
		
		//모든 정보 조회
		list = boardRepository.findAll();
		
		map. put("list", list);
		return map;
    }
	
	@RequestMapping(value="/add.do", method=RequestMethod.POST) //value 붙이고 이렇게 적으면 GET방식으로 받겠다. 안적으면 다받겠다.
    @ResponseBody
	public Map<String, Object> add(@RequestParam(value="title", required=true) String title, //required가 트루면 null비허용(에러발생)
			@RequestParam(value="contents", required=false,defaultValue="") String contents) throws Exception {
		System.out.println("add=========");
		Map<String, Object> map = new HashMap<>();
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd hh:MM");
		Date time = new Date();
		String ymd = format1.format(time);
		
		try {
			Board in = new Board();
			in.setTitle(title);
			in.setContents(contents);
			in.setDate(ymd);
			boardRepository.insert(in);
			
			map.put("returnCode", "success");
			map.put("returnDesc", "정상적으로 등록되었습니다.");
		}
		catch(Exception e){
			map.put("returnCode", "failed");
			map.put("returnDesc", "문제가 있습니다.");
		}

		return map;
    } 
}
