public class ObjProperty {
	private String name;
	private Class_ domain;
	private Class_ range;

	public ObjProperty(String name, Class_ domain, Class_ range) {
		super();
		this.name = name;
		this.domain = domain;
		this.range = range;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Class_ getDomain() {
		return domain;
	}

	public void setDomain(Class_ domain) {
		this.domain = domain;
	}

	public Class_ getRange() {
		return range;
	}

	public void setRange(Class_ range) {
		this.range = range;
	}

}