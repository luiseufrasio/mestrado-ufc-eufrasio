package br.ufc.dc.mcc.arida.easyd2rm.model;

public class DomainLiteral {
	private int id;

	private int idDataProperty;
	
	private int domain;

	private String literalType;

	public DomainLiteral(int id, int idDataProperty, int domain, String literalType) {
		super();
		this.id = id;
		this.idDataProperty = idDataProperty;
		this.domain = domain;
		this.literalType = literalType;
	}
	
	public DomainLiteral(int idDataProperty, int domain, String literalType) {
		super();
		this.idDataProperty = idDataProperty;
		this.domain = domain;
		this.literalType = literalType;
	}
	
	public int getIdDataProperty() {
		return idDataProperty;
	}

	public void setIdDataProperty(int idDataProperty) {
		this.idDataProperty = idDataProperty;
	}

	public int getDomain() {
		return domain;
	}

	public void setDomain(int domain) {
		this.domain = domain;
	}

	public String getLiteralType() {
		return literalType;
	}

	public void setLiteralType(String literalType) {
		this.literalType = literalType;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
