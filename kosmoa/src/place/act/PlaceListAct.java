package place.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import place.svc.*;
import place.vo.*;
import vo.*;
import act.*;


public class PlaceListAct implements Action {
public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<PlaceInfo> placeList = new ArrayList<PlaceInfo>();
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 9, bsize = 10, spage, epage, rcnt, pcnt;
		if (request.getParameter("cpage") != null)	cpage = Integer.parseInt(request.getParameter("cpage"));
		String keyword, bcata, scata, tag, key, area;
		
		keyword = request.getParameter("keyword");		// �˻���
		bcata = request.getParameter("bcata");			// ��з� ���̵�
		System.out.println("bcata : " + bcata);
		scata = request.getParameter("scata");			// �Һз� ���̵�
		System.out.println("Scata : " + scata);
		tag = request.getParameter("tag");				// �˻� �±�
		System.out.println("tag : " + tag);
		key = request.getParameter("key");				// �˻� Ű����
		System.out.println("key : " + key);
		area = request.getParameter("area");			// ����
		System.out.println("area : " + area);
		
		PlacePageInfo schInfo = new PlacePageInfo();	// where���� �� ���ǵ��� ������ �ٴ� �ν��Ͻ�
		String isop = "";
		isop = " pi_isop <> 'c' and pi_isshow ='y'";
		
		String where ="";		// dao���� �̿��� where��, where���� ""�̶��, and�� ������ �ʰ� where���� ���ڿ��� �ִٸ� and�� ����
		if (!isEmpty(keyword))	{
			if(where.length()<1) {	// ���� where���� ���ڿ��� ���ٸ� 
				where += " ( pi_name like '%" + keyword.trim() + "%' or sk_name like '%" + keyword.trim() + "%' ) : ";
			}
		}
		else keyword="";
		
		if (!isEmpty(bcata))	{ 
			if(where.length()<1) {
				where += " pi_bigcata = '" + bcata +"' : ";
			}else {
				where += " pi_bigcata = '" + bcata +"' : ";
			}
		}
		else bcata="";
		
		
		String where4 = "";
		if (!isEmpty(scata)) {
			String[] scatas = scata.substring(1).split(",");
			if(scatas != null) {
				where4 += "( ";
				for(int i=0; i<scatas.length; i++) {
					if (i != scatas.length-1) {
						where4 += " pi_smallcata like '%" + scatas[i] +"%' or";
					}else {
						where4 += " pi_smallcata like '%" + scatas[i] +"%' ) : ";
					}
				}
			}		
		}	
		else scata=""; 
		
		
		String where2 = "";
		if (!isEmpty(tag)) {
			String[]tags = tag.substring(1).split(",");
			if (tags != null) {
				where2 +="( ";
				for(int i=0; i<tags.length; i++) {
					if ( i != tags.length-1) {
						where2 += " st_id like '%" + tags[i] +"%' or ";
						// �±׳� Ű���� �˻���� or�� �˻�, �����̽��� tags�迭�� �ε����� ���ؼ� like ������ �������
					}else {
						where2 += " st_id like '%" + tags[i] +"%' ) : ";
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
						where3 += " sk_id like '%" + keys[i] +"%' or ";
						// �±׳� Ű���� �˻���� or�� �˻�, �����̽��� tags�迭�� �ε����� ���ؼ� like ������ �������
					}else {
						where3 += " sk_id like '%" + keys[i] +"%' ) : ";
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
		

		
		where = where + where4 +where2 + where3 + where5;
		where = where.replaceAll(":", "and");
		if (!isEmpty(where))	where = where.substring(0, where.lastIndexOf("and"));
		System.out.println("where : " + where);
		
		String wheresql = "";
		if(!where.equals(""))	wheresql = "where" + isop +"and" + where;
		else					wheresql = "where" + isop;
		System.out.println("wheresql : " + wheresql);
		
		// ���ı��� : ����(��������), ��ǰ��(��������)
		String sort = request.getParameter("sort");
		if (sort == null || sort.equals(""))	sort="idd";
		
		String order = " order by pi_" + sort.substring(0, sort.length() -1 ) +	(sort.charAt(sort.length()-1) == 'a' ? " asc" : " desc" );
		
		PlaceListSvc placeListSvc = new PlaceListSvc();
		rcnt = placeListSvc.getPlaCount (wheresql);	// ��ü �۰��� �޾ƿ�
		placeList = placeListSvc.getPlaceList(wheresql, order, cpage, psize);	// ���ǿ� �´� ���ڵ���� ArrayList�� ����
		
		int result =0;
		int result2 = 0;
		if (!tag.equals(""))	result = placeListSvc.tagTrigger(tag); // �±� Ʈ���� ȣ��
		if (!key.equals(""))	result2 = placeListSvc.keyTrigger(key);	// Ű���� Ʈ���� ȣ��
		System.out.println(result +"::" + result2);
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0 )	pcnt++;		// ��ü ������ ����
		spage = (cpage-1) / bsize * bsize + 1;	// ����� ���� ������ ��ȣ
		epage = spage + bsize - 1;
		if (epage > pcnt)	epage = pcnt;		// ����� ���� ������ ��ȣ
		
		PlacePageInfo placePageInfo = new PlacePageInfo();	// ����¡�� �ʿ��� �������� ������ �ν��Ͻ� 
		placePageInfo.setCpage(cpage);	placePageInfo.setPsize(psize);			placePageInfo.setBsize(bsize);
		placePageInfo.setSpage(spage);	placePageInfo.setEpage(epage);			placePageInfo.setRcnt(rcnt);
		placePageInfo.setPcnt(pcnt);	placePageInfo.setKeyword(keyword);		placePageInfo.setBcata(bcata);
		placePageInfo.setScata(scata);	placePageInfo.setTag(tag);				placePageInfo.setKey(key);
		placePageInfo.setSort(sort);	placePageInfo.setArea(area);
		
		System.out.println("������ : " + placePageInfo.getArea());
		
		
		
		request.setAttribute("placePageInfo", placePageInfo);
		request.setAttribute("placeList", placeList);
		
		ActionForward forward = new ActionForward();  
		forward.setPath("/courseplace/place_list.jsp");
		
		return forward;

	}

	private boolean isEmpty(String str) {		// ���ڿ��� � ���̵� ��� �ִ��� ���θ� �˻��ϴ� �޼ҵ� 
		boolean empty = true;
		if (str != null && !str.equals(""))	empty = false;
		return empty;
	}

}
