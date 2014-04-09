package beluga.module.ticket;

import beluga.core.module.Module;

/**
 * Description of the ticket system.
 * 
 * @author Valentin & Jeremy
 */
interface Ticket extends Module {
	public function browse(): Void;
	public function create(): Void;
	public function show(args: { id: Int }): Void;
	public function reopen(args: { id: Int }): Void;
	public function close(args: { id: Int }): Void;
	public function comment(args: { id: Int, message: String }): Void;
	public function submit(args: { title: String, message: String }): Void;
	public function admin(): Void;
	public function deletelabel(args: { id: Int }): Void;
	public function addlabel(args: { name: String }): Void;
	public function getBrowseContext(): Dynamic;
	public function getCreateContext(): Dynamic;
	public function getShowContext(): Dynamic;
	public function getAdminContext(): Dynamic;
}