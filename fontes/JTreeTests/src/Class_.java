import java.util.ArrayList;
import java.util.List;

public class Class_ {
	private String name;
	private List<DataProperty> dProperties = new ArrayList<DataProperty>();
	private List<ObjProperty> oProperties = new ArrayList<ObjProperty>();
	private Class_ superClass;

	public Class_(String name) {
		super();
		this.name = name;
	}

	public String getName() {
		return ("" + name.charAt(0)).toUpperCase() + name.substring(1);
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<DataProperty> getdProperties() {
		return dProperties;
	}

	public void setdProperties(List<DataProperty> dProperties) {
		this.dProperties = dProperties;
	}

	public List<ObjProperty> getoProperties() {
		return oProperties;
	}

	public void setoProperties(List<ObjProperty> oProperties) {
		this.oProperties = oProperties;
	}

	public Class_ getSuperClass() {
		return superClass;
	}

	public void setSuperClass(Class_ superClass) {
		this.superClass = superClass;
	}

}