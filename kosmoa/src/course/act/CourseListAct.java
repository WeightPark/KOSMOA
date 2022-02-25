package course.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import vo.*;
import act.*;
import course.svc.*;
import course.vo.*;


public class CourseListAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<CourseInfo> courseList = new ArrayList<CourseInfo>();
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 8, bsize = 10, spage, epage, rcnt, pcnt;
		if (request.getParameter("cpage") != null)	cpage = Integer.parseInt(request.getParameter("cpage"));
		int start =0, end=0, stlimit=0 ,endlimit = 0, totalcnt=0;		// start : �ڽ��� �ش��ϴ� ���ڵ���� limit���� ������ , ���������� ���ڵ� ���� ��� ������ �ʿ���
		if(cpage == 1)	start = 0;		// limit 0 , endlimit
		else			start = (cpage-1) * psize;		// cpage�� 2�ϰ��  (2-1) * 4 = 4,
		end = start + psize;
		String keyword, tag, key, area;
		
		// �˻����ǵ��� �޾ƿ´�.
		keyword = request.getParameter("keyword");		// �˻���
		System.out.println("keyword : " + keyword);
		tag = request.getParameter("tag");				// �˻� �±�
		//System.out.println("tag : " + tag);
		key = request.getParameter("key");				// �˻� Ű����
		System.out.println("key : " + key);
		area = request.getParameter("area");			// ����
		//System.out.println("area : " + area);

		CoursePageInfo SchInfo = new CoursePageInfo();	// where���� �� ���ǵ��� ������ �ٴ� �ν��Ͻ�
		String isop = "";		// �ڽ����� �ҷ����� �� ���
		String iscnt = "";		// �ڽ��� ������ �ҷ��� ���
		isop = " ci_isview='y'  ";		// ��� ��������� ����� where���� �պκ�
		String where ="";		// dao���� �̿��� where��, where���� ""�̶��, and�� ������ �ʰ� where���� ���ڿ��� �ִٸ� and�� ����
		if (!isEmpty(keyword))	{
			if(where.length()<1) {	// ���� where���� ���ڿ��� ���ٸ� 
				where += " ci_name like '%" + keyword.trim() + "%' or  ci_sk_name like '%" +keyword.trim() +"%'  : ";
			}
		}
		else keyword="";
		
		String where2 = "";
		if (!isEmpty(tag)) {
			String[]tags = tag.substring(1).split(",");
			if (tags != null) {
				where2 +="( ";
				for(int i=0; i<tags.length; i++) {
					if ( i != tags.length-1) {
						where2 += " ci_st_id like '%" + tags[i] +"%' or ";
						// �±׳� Ű���� �˻���� or�� �˻�, �����̽��� tags�迭�� �ε����� ���ؼ� like ������ �������
					}else {
						where2 += " ci_st_id like '%" + tags[i] +"%' ) : ";
						// �ش� �迭�� �ε����� �������̶��, �ڿ� or�� �ٿ����� ���� 
					}
				}
			}
		}else		tag = "";	
		
		
		String where3 = "";
		if (!isEmpty(key)) {
			String[] keys = key.substring(1).split(",");
			if (keys != null) {
				where3 += "( ";
				for(int i=0; i<keys.length; i++) {
					if ( i != keys.length-1) {
						where3 += " ci_sk_id like '%" + keys[i] +"%' or ";
						// �±׳� Ű���� �˻���� or�� �˻�, �����̽��� tags�迭�� �ε����� ���ؼ� like ������ �������
					}else {
						where3 += " ci_sk_id like '%" + keys[i] +"%' ) : ";
						// �ش� �迭�� �ε����� �������̶��, �ڿ� or�� �ٿ����� ���� 
					}
				}
			}
		}else		key = "";
		
		
		String where5="";
		if (!isEmpty(area)) {
			String[] areas = area.substring(1).split(",");
			if (areas != null) {
				where5 += "( ";
				for(int i=0; i<areas.length; i++) {
					if ( i != areas.length-1) {
						where5 += "  pi_area like '%" + areas[i] +"%' or ";
						// �±׳� Ű���� �˻���� or�� �˻�, �����̽��� tags�迭�� �ε����� ���ؼ� like ������ �������
					}else {
						where5 += "  pi_area like '%" + areas[i] +"%'  ) : ";
						// �ش� �迭�� �ε����� �������̶��, �ڿ� or�� �ٿ����� ���� 
					}
				}
			}
		}else		area = "";
		
	
		
		where = where +where2 + where3 + where5;
		where = where.replaceAll(":", "and");
		if (!isEmpty(where))	where = where.substring(0, where.lastIndexOf("and"));
		
		String wheresql = "";		// �� ����� �ҷ��ö� ����� sql	(�ش��ϴ� �ڽ��� ��� ���ڵ� ����)
		if(where != null && !where.equals(""))	wheresql = "where" + isop +"and" + where;
		else									wheresql = "where" + isop;
		System.out.println("wheresql : " + wheresql);

		
		// ���ı��� : ����(��������), ��ǰ��(��������)
		String sort = request.getParameter("sort");
		if (sort == null || sort.equals(""))	sort="idd";
		
		String order = " order by ci_" + sort.substring(0, sort.length() -1 ) +	(sort.charAt(sort.length()-1) == 'a' ? " asc" : " desc" );
System.out.println("sort : " + (sort.length() -1));
		CourseListSvc courseListSvc = new CourseListSvc();
		
		totalcnt = courseListSvc.getTotalCount(wheresql, order ,start, end);			// �ش� �ڽ��� ���ڵ� ������ ������
		
		if(cpage > 1 ) {	
			stlimit = courseListSvc.getStlimitCount(wheresql, order ,start);		// cpage�� 1���� Ŭ���, ���������� ���ڵ��� ������ �޾ƿ� 
		}
		endlimit = totalcnt;				// ������ �����;��� ���ڵ���� ��(totalcnt)
		System.out.println("start : " + start +", stlimit : " + stlimit + " , endlimit : " + endlimit);
		rcnt = courseListSvc.getCourseCount (wheresql);	// ��ü �ڽ��� ������  �޾ƿ�
		courseList = courseListSvc.getCourseList(wheresql, order, stlimit, endlimit);	// ���ǿ� �´� ���ڵ���� ArrayList�� ����
		
		int result =0;
		int result2 = 0;
		if (!tag.equals(""))	result = courseListSvc.tagTrigger(tag); // �±� Ʈ���� ȣ��
		if (!key.equals(""))	result2 = courseListSvc.keyTrigger(key);	// Ű���� Ʈ���� ȣ��
		// System.out.println(result +"::" + result2);
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0 )	pcnt++;		// ��ü ������ ����
		spage = (cpage-1) / bsize * bsize + 1;	// ����� ���� ������ ��ȣ
		epage = spage + bsize - 1;
		if (epage > pcnt)	epage = pcnt;		// ����� ���� ������ ��ȣ
		
		CoursePageInfo coursePageInfo = new CoursePageInfo();	// ����¡�� �ʿ��� �������� ������ �ν��Ͻ� 
		coursePageInfo.setCpage(cpage);	coursePageInfo.setPsize(psize);			coursePageInfo.setBsize(bsize);
		coursePageInfo.setSpage(spage);	coursePageInfo.setEpage(epage);			coursePageInfo.setRcnt(rcnt);
		coursePageInfo.setPcnt(pcnt);	coursePageInfo.setKeyword(keyword);		coursePageInfo.setTag(tag);				
		coursePageInfo.setKey(key);		coursePageInfo.setSort(sort);			coursePageInfo.setArea(area);


		
		
		request.setAttribute("coursePageInfo", coursePageInfo);
		request.setAttribute("courseList", courseList);
		
		ActionForward forward = new ActionForward();  
		forward.setPath("/courseplace/course_list.jsp");
		
		return forward;

	}

	private boolean isEmpty(String str) {		// ���ڿ��� � ���̵� ��� �ִ��� ���θ� �˻��ϴ� �޼ҵ� 
		boolean empty = true;
		if (str != null && !str.equals(""))	empty = false;
		return empty;
	}
}
