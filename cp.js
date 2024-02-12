javascript:(function(){
    var rm = [' - Google Docs', ' - Google Sheets', ' - YouTube'];

    function listener(e) {
        let u = location.href,
            t = document.title;
        for(let s of rm) t = t.replace(s, '');
        e.clipboardData.setData("text/plain", `<${t} ^ ${u}>`);
        e.preventDefault();
    }

    document.addEventListener("copy", listener);
    document.execCommand("copy");
    document.removeEventListener("copy", listener);
})();
