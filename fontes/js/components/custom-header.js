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
                <li class="itensmenu"><a href="../html/main.html"><span id="itemmenuhome" class="material-symbols-outlined">home</span>Início</a></li>
                <li class="itensmenu"><a href="../html/quemsou.html"><span id="itemmenuhealthy" class="material-symbols-outlined">self_improvement</span>Marcela Daguer</a></li>
                <li class="itensmenu"><a href="../html/terapias.html"><span id="itemmenuhealthy" class="material-symbols-outlined">digital_wellbeing</span>Terapias</a></li>
                <li class="itensmenu"><a href="https://marceladaguer.wordpress.com/" target="_blank"><span id="itemmenuarticle" class="material-symbols-outlined">article</span>Blog</a></li>
                <li class="itensmenu"><a href="https://wa.me/5511997111413" target="_blank"><span id="itemmenuarticle" class="material-symbols-outlined">chat</span>(11) 99711.1413</a></li>
                <li class="itensmenu"><a href="mailto: marceladaguer@gmail.com" target="_blank"><span id="itemmenuarticle" class="material-symbols-outlined">alternate_email</span>marceladaguer@gmail.com</a></li>
            </ul>
          </nav>
      </div>
      <div id="divheader">
        <div id="divmenu">
            <nav id="navmenuitens2">
                <ul>
                    <li><a href="../html/main.html">Início</a></li>
                    <li><a href="../html/quemsou.html">Marcela Daguer</a></li>
                    <li><a href="../html/terapias.html">Terapias</a></li>
                    <li><a href="https://marceladaguer.wordpress.com/" target="_blank">Blog</a></li>
                    <li>
                        <a href="https://wa.me/5511997111413" target="_blank"><span class="material-symbols-outlined">chat</span></a>
                        <a href="mailto: marceladaguer@gmail.com" target="_blank"><span class="material-symbols-outlined">alternate_email</span></a>
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