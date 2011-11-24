package br.ufc.dc.mcc.arida.easyd2rm.model;

import java.util.List;

public class DataProperty {
	private int id;

	private String prefix;

	private String name;

	private List<DomainLiteral> domains;

	public DataProperty(int id, String prefix, String name) {
		this.id = id;
		this.prefix = prefix;
		this.name = name;
	}

	public DataProperty(String prefix, String name) {
		this.prefix = prefix;
		this.name = name;
	}

	public List<DomainLiteral> getDomains() {
		return domains;
	}

	public void setDomains(List<DomainLiteral> domains) {
		this.domains = domains;
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
