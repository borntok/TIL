(function () {
  "use strict";

  const commands = [
    {
      cmd: "backColor",
      value: "blue",
      label: "배경 컬러",
    },
    {
      cmd: "bold",
      label: "굵기",
    },
    {
      cmd: "justifyCenter",
      label: "가운데 정렬",
    },
    {
      cmd: "justifyFull",
      label: "양쪽 정렬",
    },
    {
      cmd: "justyfiLeft",
      label: "좌측 정렬",
    },
    {
      cmd: "justyfiRight",
      label: "우측 정렬",
    },
    {
      cmd: "underline",
      label: "밑줄",
    },
  ];

  const get = (target) => {
    return document.querySelector(target);
  };

  const commandObject = {};

  const doCommand = (cmdKey) => {
    const cmd = commandObject[cmdKey];
    const val = cmd.value ? prompt("값을 입력해주세요", cmd.value) : "";
    document.execCommand(cmd.cmd, false, val);
  };

  const $editorButtons = get(".editor_buttons");
  const $showEditorButton = get(".show_editor_button");
  const $showHTMLButton = get(".show_html_button");
  const $editorEdit = get(".editor.edit");
  const $editorHTML = get(".editor.html");

  const onClickShowEditorButton = () => {
    $editorEdit.innerHTML = $editorHTML.innerText;
    $editorHTML.classList.toggle("show");
    $editorEdit.classList.toggle("show");
  };

  const onClickShowHTMLButton = () => {
    $editorHTML.innerText = $editorEdit.innerHTML;
    $editorEdit.classList.toggle("show");
    $editorHTML.classList.toggle("show");
  };

  const init = () => {
    commands.map((command) => {
      commandObject[command.cmd] = command;
      const element = document.createElement("button");
      element.innerText = command.label;
      element.addEventListener("click", (e) => {
        e.preventDefault();
        doCommand(command.cmd);
      });
      $editorButtons.appendChild(element);
    });
  };

  $showEditorButton.addEventListener("click", onClickShowEditorButton);
  $showHTMLButton.addEventListener("click", onClickShowHTMLButton);

  init();
})();
