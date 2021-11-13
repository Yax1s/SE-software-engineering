window.sweet = data => {
    Swal.fire({
        title: data.title ? data.title : 'Oops...',
        text: data.msg,
        icon: data.type
    });
}

window.toast = data => {
    Toastify({
        text: data.msg,
        duration: 7000,
        close: true,
        className: data.type,
    }).showToast();
}
