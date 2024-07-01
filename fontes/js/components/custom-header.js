class customHeader extends HTMLElement {
    constructor() {
      super();
    }
  
    connectedCallback() {
      this.innerHTML = `
      <header>
      <div id="divheadermobile">
          <div id="divimagesheader">
              <div id="divimageburguer">
                  <span id="menuburguer" class="material-symbols-outlined" onclick="clickMenu()">menu</span>
              </div>
              <div id="divimagemlogoazul"><div id="divimagemlogoazulaux"></div></div>
          </div>
          <nav id="navmenuitens">
            <ul class="headerUL">
                <li><a href="../index.html"><span id="itemmenuhome" class="material-symbols-outlined">home</span>Início</a></li>
                <li><a href="../quemsou.html"><span id="itemmenuhealthy" class="material-symbols-outlined">self_improvement</span>Marcela Daguer</a></li>
                <li><a href="../terapias.html"><span id="itemmenuhealthy" class="material-symbols-outlined">digital_wellbeing</span>Terapias</a></li>
                <li><a href="https://marceladaguer.wordpress.com/" target="_blank"><span id="itemmenuarticle" class="material-symbols-outlined">article</span>Blog</a></li>
                <li class="itensmenu">
                    <a href="https://www.instagram.com/marceladaguer?igsh=MWh6YWQyNzc0eGNqZw==" target="_blank"><i class="fa-brands fa-instagram logo"></i></a>&nbsp;&nbsp;&nbsp;
                    <a href="https://wa.me/5511997111413" target="_blank"><i class="fa-brands fa-whatsapp logo"></i></a>&nbsp;&nbsp;&nbsp;
                    <a href="mailto: marceladaguer@gmail.com" target="_blank"><i class="fa-solid fa-square-envelope logo"></i></a>
                </li>
            </ul>
          </nav>
      </div>
      <div id="divheader">
        <div id="divmenu">
            <nav id="navmenuitens2">
                <ul>
                    <li><a href="../index.html">Início</a></li>
                    <li><a href="../quemsou.html">Marcela Daguer</a></li>
                    <li><a href="../terapias.html">Terapias</a></li>
                    <li><a href="https://marceladaguer.wordpress.com/" target="_blank">Blog</a></li>
                    <li>
                        <a href="https://www.instagram.com/marceladaguer?igsh=MWh6YWQyNzc0eGNqZw==" target="_blank"><i class="fa-brands fa-instagram logo"></i></a>&nbsp;&nbsp;&nbsp;
                        <a href="https://wa.me/5511997111413" target="_blank"><i class="fa-brands fa-whatsapp logo"></i></a>&nbsp;&nbsp;&nbsp;
                        <a href="mailto: marceladaguer@gmail.com" target="_blank"><i class="fa-solid fa-square-envelope logo"></i></a>
                    </li>
                </ul>
            </nav>
        </div>
        <div id="divimagemlogoazul2"><div id="divimagemlogoazulaux2"></div></div>
      </div>
  </header>
      `;
    }
  }
  
  customElements.define('custom-header', customHeader);