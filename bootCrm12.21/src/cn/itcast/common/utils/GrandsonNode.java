package cn.itcast.common.utils;

public class GrandsonNode {//第三级

	private String text;

	
	public GrandsonNode(String text) {
	super();
	this.text = text;
}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Override
	public String toString() {
		return "GrandsonNode [text=" + text + "]";
	}
	
	
}
