package br.ufc.dc.mcc.arida.easyd2rm.model;

public class RdfClass {
	private int id;

	private String prefix;

	private String name;

	public RdfClass(int id, String prefix, String name) {
		this.id = id;
		this.prefix = prefix;
		this.name = name;
	}
	
	public RdfClass(String prefix, String name) {
		this.prefix = prefix;
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
