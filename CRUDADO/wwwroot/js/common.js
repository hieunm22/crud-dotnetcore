// const deleteSelected = () => {
// 	const _confirm = confirm('Do you really want to remove selected teacher(s)?')
// 	if (_confirm) {
// 		const checkboxes = document.querySelectorAll('.squall-20-checkbox').toArray()
// 		let parameters = ''
// 		checkboxes.forEach((e, i) => {
// 			if (e.checked) {
// 				const id = e.id.substr('teacher-'.length)
// 				parameters += id + ','
// 			}
// 		})
// 		parameters = parameters.substr(parameters.length - 1)
// 	}

// 	return _confirm
// }

// const isChecked = ckb => ckb.checked

// NodeList.prototype.toArray = function() {
// 	let array = []
// 	this.forEach(e => array.push(e))
// 	return array
// }