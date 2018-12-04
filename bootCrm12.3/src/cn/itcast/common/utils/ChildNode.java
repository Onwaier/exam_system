package cn.itcast.common.utils;

public class ChildNode {
	private String text;

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public ChildNode(String text) {
		super();
		this.text = text;
	}

	@Override
	public String toString() {
		return "ChildNode [text=" + text + "]";
	}
	
	
}
