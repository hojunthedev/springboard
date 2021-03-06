package com.example.boardMongo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.apache.commons.io.IOUtils;

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
	
	@RequestMapping("/board2.do")
    public String board2() throws Exception {
	return "/board2";
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
	public Map<String, Object> 
			add(
			@RequestParam(value="title", required=true) String title, //required가 트루면 null비허용(에러발생)
			@RequestParam(value="contents", required=false,defaultValue="") String contents,
			@RequestPart(value="file", required=false) MultipartFile file) throws Exception {
		System.out.println("add=========");
		Map<String, Object> map = new HashMap<>();
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd hh:MM");
		Date time = new Date();
		String ymd = format1.format(time);
		
		try {
			String repository = env.getProperty("user.file.upload");
			String fname="";
			if(file != null && file.getSize() >0) {
				fname = file.getOriginalFilename();
				FileOutputStream fos = new FileOutputStream(new File(repository+File.separator+fname));
				IOUtils.copy(file.getInputStream(), fos);
				fos.close();
			}
			
			Board in = new Board();
			in.setTitle(title);
			in.setContents(contents);
			in.setFname(fname);
			in.setDate(ymd);
			boardRepository.insert(in);
			
			map.put("returnCode", "success");
			map.put("returnDesc", "정상적으로 등록되었습니다.");
		}
		catch(Exception e){
			map.put("returnCode", "failed");
			map.put("returnDesc", "add에 문제가 있습니다.");
		}

		return map;
    } 
	
	@RequestMapping(value="/mod.do", method=RequestMethod.POST) 
    @ResponseBody
	public Map<String, Object> mod(
			@RequestParam(value="id", required=true) String id, 
			@RequestParam(value="title", required=true) String title,
			@RequestParam(value="contents", required=false,defaultValue="") String contents,
			@RequestPart(value="file", required=false) MultipartFile file)  throws Exception {
		System.out.println("mod=========");
		
		Map<String, Object> map = new HashMap<>();
				
		try {
			String repository = env.getProperty("user.file.upload");
			String fname="";
			if(file != null && file.getSize() >0) {
				fname = file.getOriginalFilename();
				FileOutputStream fos = new FileOutputStream(new File(repository+File.separator+fname));
				IOUtils.copy(file.getInputStream(), fos);
				fos.close();
			}
			
			Query query = new Query();
			Criteria activityCriteria = Criteria.where("id").is(id);
			query.addCriteria(activityCriteria);
			//activityCriteria = Criteria.where("title").is(title);
			//query.addCriteria(activityCriteria);
			List<Board> out = mongoTemplate.find(query, Board.class);
			
			if(out.size() > 0) {
				Board in= out.get(0);	//한건 삭제
				in.setTitle(title);
				in.setContents(contents);
				in.setFname(fname);
				boardRepository.save(in);
			}
			map.put("returnCode", "success");
			map.put("returnDesc", "정상적으로 수정되었습니다.");
		}
		catch(Exception e){
			map.put("returnCode", "failed");
			map.put("returnDesc", "mod에 문제가 있습니다.");
		}

		return map;
    } 
	
	@RequestMapping(value="/del.do", method=RequestMethod.POST) 
    @ResponseBody
	public Map<String, Object> del(
			@RequestParam(value="id", required=true) String id, 
			@RequestParam(value="title", required=true) String title, 
			@RequestParam(value="contents", required=false,defaultValue="") String contents) throws Exception {
		System.out.println("del=========");
		Map<String, Object> map = new HashMap<>();
				
		try {
			Query query = new Query();
			Criteria activityCriteria = Criteria.where("id").is(id);
			query.addCriteria(activityCriteria);
			activityCriteria = Criteria.where("title").is(title);
			query.addCriteria(activityCriteria);
			List<Board> out = mongoTemplate.find(query, Board.class);
			
			if(out.size() > 0) {
				Board in= out.get(0);	//한건 삭제
				boardRepository.delete(in);
			}
			
			map.put("returnCode", "success");
			map.put("returnDesc", "정상적으로 삭제되었습니다.");
		}
		catch(Exception e){
			map.put("returnCode", "failed");
			map.put("returnDesc", "문제가 있습니다.");
		}

		return map;
    } 
	
	@RequestMapping(value="/delImg.do", method=RequestMethod.POST) 
    @ResponseBody
	public Map<String, Object> delImg(
			@RequestParam(value="id", required=true) String id, 
			@RequestParam(value="title", required=true) String title, 
			@RequestParam(value="contents", required=false,defaultValue="") String contents) throws Exception {
		System.out.println("delImg=========");
		Map<String, Object> map = new HashMap<>();
				
		try {
			Query query = new Query();
			Criteria activityCriteria = Criteria.where("id").is(id);
			query.addCriteria(activityCriteria);
			activityCriteria = Criteria.where("title").is(title);
			query.addCriteria(activityCriteria);
			List<Board> out = mongoTemplate.find(query, Board.class);
			
			if(out.size() > 0) {
				Board in= out.get(0);	//한건 삭제
				
				String repository = env.getProperty("user.file.upload");
				String fname= repository+File.separator+in.getFname();
				File delFile = new File(fname);
				
				if(delFile.exists()) {
					delFile.delete();
				}
				
				in.setFname("");
				boardRepository.save(in);
			}
			
			map.put("returnCode", "success");
			map.put("returnDesc", "정상적으로 삭제되었습니다.");
		}
		catch(Exception e){
			map.put("returnCode", "failed");
			map.put("returnDesc", "데이터 삭제에 실패했습니다.");
		}

		return map;
    } 
	
	@RequestMapping(value="/img.do")
	@ResponseBody
	public String getImageWithMediaType(
			@RequestParam(value="fname", required=false, defaultValue="") String fname,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("img=======");
		String repository= env.getProperty("user.file.upload");
		
		String base64Encoded = "";
		if(fname.contains(",")) {
			fname = fname.substring(0,fname.indexOf(","));
		}
		fname = repository+File.separator+fname;
		System.out.println("dir:" + fname);
		
		File file = new File(fname);
		if(file.exists() && file.isFile()) {
			InputStream in = new FileInputStream(fname);
			byte[] bytes = IOUtils.toByteArray(in);
			byte[] encodeBase64 = Base64.getEncoder().encode(bytes);
			base64Encoded = new String(encodeBase64, "UTF-8");
			
			in.close();
 		}
		
		return base64Encoded;
	}
			
}
