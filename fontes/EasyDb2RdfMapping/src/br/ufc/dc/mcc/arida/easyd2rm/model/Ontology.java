package br.ufc.dc.mcc.arida.easyd2rm.model;

public class Ontology {

	private String prefix;
	private String uri;

	public Ontology(String prefix, String uri) {
		super();
		this.prefix = prefix;
		this.uri = uri;
	}

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}

}
