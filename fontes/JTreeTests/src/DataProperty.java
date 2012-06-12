public class DataProperty {
	private String name;
	private Class_ domain;
	private String range;

	public DataProperty(String name, Class_ domain, String range) {
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

	public String getRange() {
		return range;
	}

	public void setRange(String range) {
		this.range = range;
	}

}
