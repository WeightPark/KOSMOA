package reserve.vo;

import java.util.*;

public class ReservedListInfo {
	private ArrayList<CourseReservedInfo> courseList = new ArrayList<CourseReservedInfo>();
	private ArrayList<PlaceReservedInfo> placeList = new ArrayList<PlaceReservedInfo>();
	
	public ArrayList<CourseReservedInfo> getCourseList() {
		return courseList;
	}
	public void setCourseList(ArrayList<CourseReservedInfo> courseList) {
		this.courseList = courseList;
	}
	public ArrayList<PlaceReservedInfo> getPlaceList() {
		return placeList;
	}
	public void setPlaceList(ArrayList<PlaceReservedInfo> placeList) {
		this.placeList = placeList;
	}
}
