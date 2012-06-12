import java.awt.BorderLayout;
import java.awt.Container;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTextField;
import javax.swing.JTree;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.DefaultMutableTreeNode;

import com.hp.hpl.jena.ontology.DatatypeProperty;
import com.hp.hpl.jena.ontology.ObjectProperty;
import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntModelSpec;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.util.iterator.ExtendedIterator;

public class RBA extends JFrame implements TreeSelectionListener {
	private static final long serialVersionUID = 1L;

	private JTree targetTree;
	private JTree srcTree;
	private JTextField currentSelectionField;
	static Map<String, Class_> classesTarget = new HashMap<String, Class_>();
	static Map<String, Class_> classesSource = new HashMap<String, Class_>();

	public static void main(String[] args) throws Exception {
		String targetOnto = "vendas.owl";
		String srcOnto = "amazon.owl";

		loadOntology(srcOnto, classesSource);
		loadOntology(targetOnto, classesTarget);
		new RBA(targetOnto, srcOnto);
	}

	public RBA(String rootTarget, String rootSource) {
		super("R2RML Mapping By Assertions");
		Container content = getContentPane();
		DefaultMutableTreeNode rootT = new DefaultMutableTreeNode(rootTarget);

		DefaultMutableTreeNode child;
		DefaultMutableTreeNode grandChild;

		classesTarget.values();
		for (Iterator<Class_> iterator = classesTarget.values().iterator(); iterator
				.hasNext();) {
			Class_ c = (Class_) iterator.next();

			child = new DefaultMutableTreeNode(c.getName());
			rootT.add(child);

			List<DataProperty> dProperties = c.getdProperties();
			for (DataProperty dataProperty : dProperties) {
				grandChild = new DefaultMutableTreeNode(dataProperty.getName()
						+ " (" + dataProperty.getRange() + ")");
				child.add(grandChild);
			}

			List<ObjProperty> oProperties = c.getoProperties();
			for (ObjProperty objProperty : oProperties) {
				grandChild = new DefaultMutableTreeNode(objProperty.getName()
						+ " (" + objProperty.getRange().getName() + ")");
				child.add(grandChild);
			}
		}

		targetTree = new JTree(rootT);
		targetTree.addTreeSelectionListener(this);

		DefaultMutableTreeNode rootS = new DefaultMutableTreeNode(rootSource);

		DefaultMutableTreeNode childS;
		DefaultMutableTreeNode grandChildS;

		classesSource.values();
		for (Iterator<Class_> iterator = classesSource.values().iterator(); iterator
				.hasNext();) {
			Class_ c = (Class_) iterator.next();

			childS = new DefaultMutableTreeNode(c.getName());
			rootS.add(childS);

			List<DataProperty> dProperties = c.getdProperties();
			for (DataProperty dataProperty : dProperties) {
				grandChildS = new DefaultMutableTreeNode(dataProperty.getName()
						+ " (" + dataProperty.getRange() + ")");
				childS.add(grandChildS);
			}

			List<ObjProperty> oProperties = c.getoProperties();
			for (ObjProperty objProperty : oProperties) {
				grandChildS = new DefaultMutableTreeNode(objProperty.getName()
						+ " (" + objProperty.getRange().getName() + ")");
				childS.add(grandChildS);
			}
		}

		srcTree = new JTree(rootS);
		srcTree.addTreeSelectionListener(new TreeSelectionListener() {

			@Override
			public void valueChanged(TreeSelectionEvent e) {
				currentSelectionField.setText("Current Selection: "
						+ srcTree.getLastSelectedPathComponent().toString());
			}
		});
		JSplitPane jSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,
				new JScrollPane(targetTree), new JScrollPane(srcTree));
		content.add(jSplitPane, BorderLayout.CENTER);
		jSplitPane.setOneTouchExpandable(true);
		jSplitPane.setDividerLocation(200);

		currentSelectionField = new JTextField("Current Selection: NONE");
		content.add(currentSelectionField, BorderLayout.SOUTH);
		setSize(250, 275);
		setVisible(true);
	}

	public void valueChanged(TreeSelectionEvent event) {
		currentSelectionField.setText("Current Selection: "
				+ targetTree.getLastSelectedPathComponent().toString());
	}

	private static void loadOntology(String onto, Map<String, Class_> classes)
			throws FileNotFoundException {
		OntModel ontModel = ModelFactory
				.createOntologyModel(OntModelSpec.OWL_MEM);
		ontModel.read(new FileInputStream(new File(onto)),
				"http://example.org/vendas/", "TURTLE");

		ExtendedIterator<OntClass> i = ontModel.listClasses();
		while (i.hasNext()) {
			OntClass ontClass = (OntClass) i.next();

			String name = ontClass.getLocalName();

			if (classes.get(name) == null) {
				Class_ c = new Class_(name);
				classes.put(name, c);

				OntClass superClass = ontClass.getSuperClass();
				if (superClass != null) {
					String superName = superClass.getLocalName();
					Class_ superC = classes.get(superName);

					if (superC == null) {
						superC = new Class_(superName);
						classes.put(superName, superC);
					}

					c.setSuperClass(superC);
				}
			}
		}

		ExtendedIterator<DatatypeProperty> i2 = ontModel
				.listDatatypeProperties();
		while (i2.hasNext()) {
			DatatypeProperty datatypeProperty = (DatatypeProperty) i2.next();

			String dClassName = datatypeProperty.getDomain().getLocalName();
			Class_ dClass = classes.get(dClassName);
			String dpName = datatypeProperty.getLocalName();
			if (dpName.indexOf('_') > -1) {
				String[] array = dpName.split("_");
				dpName = array[array.length - 1];
			}
			String rangeName = datatypeProperty.getRange().getLocalName();

			DataProperty dp = new DataProperty(dpName, dClass, rangeName);
			dClass.getdProperties().add(dp);
		}

		ExtendedIterator<ObjectProperty> i3 = ontModel.listObjectProperties();
		while (i3.hasNext()) {
			ObjectProperty objectProperty = (ObjectProperty) i3.next();

			String dClassName = objectProperty.getDomain().getLocalName();
			String rClassName = objectProperty.getRange().getLocalName();
			String opName = objectProperty.getLocalName();
			if (opName.indexOf('_') > -1) {
				String[] array = opName.split("_");
				opName = array[array.length - 1];
			}

			Class_ dClass = classes.get(dClassName);
			Class_ rClass = classes.get(rClassName);

			ObjProperty op = new ObjProperty(opName, dClass, rClass);
			dClass.getoProperties().add(op);
		}
	}
}
