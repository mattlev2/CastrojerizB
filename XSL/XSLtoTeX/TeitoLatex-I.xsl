<?xml version="1.0" encoding="ISO-8859-1"?>
<!--PROBLEMES-->
<!--REFAIRE LES REGLES D AJOUTS EN MARGE-->
<!--notable: tout ce qui est notable (renommer le type)-->
<!--Int�grer les notes dans un apparat de lemmes...-->
<!--R�gulariser les diff�rences dans les add entre above et pas above-->

<!-- IDEE: G�rer les modifications textuelles: Et si je faisais ma transformation en deux temps? D'abord, toutes les grosses transformations EN GARDANT UNE STRUCTURE XML BASIQUE
    et bien form�e (une d�claration d'entit�, etc) Sur cette transformation, en faire une seconde qui va supprimer tout ce qui est xml et garder que le texte ET qui 
pourra modifier les espaces simplement (translate ou un autre truc) ainsi qu'adapter les d�tails � LaTeX, comme les - - qui donne un tiret correct, ou transformer tous les e en &, etc-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:tex="placeholder.uri"
    exclude-result-prefixes="tex">
    <!--Le but recherch� avec cette feuille est la cr�ation de l'�dition critique � partir d'un 
        manuscrit, ici le Ms. K.I.5 de la Biblioth�que de l'Escorial, avec apparat positif-->
    <!--ATTENTION: Cette feuille XSL ppermet de transformer l'�dition critique .xml en document Tex NON COMPILABLE:
        le r�sultat sera uniquement le texte, les notes, et l'apparat.-->
    <!--RECOMMAND�: la feuille xsl est construite pour une utilisation du document .tex comme annexe 
        vers laquelle pointe le document principal (utilisant \input{...} par exemple).-->
    <!--IMP�RATIF: Le package latex utilis� pour l'apparat est ednotes (https://www.ctan.org/pkg/ednotes). 
    Il doit imp�rativement �tre accompagn� du package lineno (https://www.ctan.org/pkg/lineno)
    et du package manyfoot (https://www.ctan.org/pkg/manyfoot) pour 
    les diff�rents niveaux de notes 
    (\DeclareNewFootnote{B}[arabic]
\usepackage{perpage}
\MakePerPage{footnote}
\renewcommand{\thefootnote}{\alph{footnote}} pour adapter le pr�ambule LaTex � la feuille de transformation)
    , ainsi que du package marginpar (https://www.ctan.org/pkg/marginpar)
    pour permettre l'indication en marge des lacunes et des commencements/fins de t�moins-->
    <!--Je propose mon preambule LaTex � l'adresse: http://perso.ens-lyon.fr/matthias.gille-levenson/preambule.txt. 
    Si le lien est p�rim�, me contacter sur mon adresse ens: matthias.gille-levenson[arobase]ens[point]fr -->
    <!--Cette feuille est adapt�e � mon propre document XML-->
    <!--Merci � Arianne Pinche pour son aide pr�cieuse dans cette feuille-->
    <!--Merci � Marjorie Burghart de m'avoir envoy� sa feuille de transformation qui m'a bien aid�-->
    <xsl:output method="xml" omit-xml-declaration="no" encoding="ISO-8859-1"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="fr">
            <text>
                <xsl:text>
        \vfill\vfill
        \noindent\textit{La foliation concerne uniquement le} codex optimus, \textit{pour l'instant KI5}.\newline
        ~\newline\underline{Apparat}\newline\newline
         Pour des raisons de temps, mon apparat n'est pas le plus acad�miquement conforme. Comme suit:\newline\newline
        \fbox{\begin{minipage}{1\textwidth}
     \begin{center}
         \textbf{n. de la ligne} lemme ] \textit{t�moin du lemme} ; le�on(s) rejet�e(s) ; \textit{t�moin(s)}
     \end{center}
\end{minipage}}~\newline\newline
        \textit{Les ajouts �ditoriaux sont indiqu�s entre crochets &lt; &gt;.\newline 
        Les suppressions du copistes sont indiqu�es par le biais de crochets doubles [[ ]].\newline 
        Les ajouts du copistes sont indiqu�s en italique.\newline
        Les passages illisibles sont indiqu�s par un espace de tabulation. \newline
        J'indique par un [�] l'absence d'un mot dans une le�on.\newline
        Entre deux signes d'interrogation ? ?, les mots difficiles � lire.\newline
        Les passages endommag�s sont \underline{soulign�s}.\newline
        Ainsi par exemple, un apparat qui propose le mot suivant: }ve?[[r]]\textit{n}?g?[[ue]]\textit{a}?n�a \textit{signifie que l'on se trouve devant un 
        mot \textit{verguen�a} qui a probablement �t� corrig� en \textit{vengan�a} sans que la correction soit absolument certaine. \newline
        Les espaces qui apparaissent dans l'apparat sont signifiants: ils t�moignent d'un espace dans le texte.\newline
        REVOIR POUR LES LACUNES ET LES TROU.\newline
        Je dois dans certains cas faire r�f�rence au changement de ligne: il sera indiqu� par une double barre oblique //. }\newline\newline
        \underline{Fonctionnement des notes}\newline\newline
        Je propose quatre niveaux de notes: les notes de marge les lacunes et les arr�ts/reprises des diff�rents t�moins.
        Vient ensuite le premier niveau de notes, alphab�tique, (notes concernant les t�moins en g�n�ral), les notes d'apparat, 
        et enfin les notes de 
        commentaire th�matique. 
       \vfill\vfill\vfill ~\newpage
       
       </xsl:text>
                <xsl:text>\textbf{Sigles des t�moins}\newline\newline</xsl:text>
                <xsl:for-each
                    select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness">
                    <xsl:text>\noindent \textbf{</xsl:text>
                    <xsl:value-of select="@xml:id"/>
                    <xsl:text>}: </xsl:text>
                    <xsl:value-of select="text()"/>
                    <xsl:text>\newline </xsl:text>
                </xsl:for-each>
                <xsl:text> 
            \setstretch{1,1}
           \begin{linenumbers}[1]
           <!-- changes the default format of the linenumbers-->
           \renewcommand\linenumberfont{\normalfont\mdseries\footnotesize}
           <!-- changes the default format of the linenumbers-->
        \modulolinenumbers[5]</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>\end{linenumbers}</xsl:text>
            </text>
        </TEI>
    </xsl:template>


    <xsl:template match="tei:teiHeader"/>
    <xsl:template match="tei:witness">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:persName[@type = 'auteur']">
        <xsl:text>\textsc{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <!-- Mettre en valeur tous les lemmes qui ne sont pas tir�s du codex optimus-->
    <xsl:template match="./tei:lem[not(contains(concat(' ', @wit, ' '), ' #Q '))]">
        <xsl:text>\textbf{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    <!-- Mettre en valeur tous les lemmes qui ne sont pas tir�s du codex optimus-->



    <!--Notes en bas de page. -->
    <!--Est ce que je me complique pas la vie � �crire deux fois les m�mes r�gles?-->
    <!--Si la note est th�matique, second niveau de notes, appel en chiffres arabes-->
    <xsl:template match="tei:note">
        <xsl:if test="@type = 'thematique'">
            <xsl:text>\footnoteB{</xsl:text>
            <xsl:choose>
                <xsl:when test="./tei:foreign">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="./tei:persName[@type = 'auteur']">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="./tei:hi[@rendition = 'up']">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>}</xsl:text>
        </xsl:if>
        <!--Si la note est th�matique-->
        <!--Si la note est structurelle (description d'un t�moin dans sa mat�rialit�),
            premier niveau de notes, appel en lettres.-->
        <xsl:if test="@type = 'structure'">
            <xsl:if test="@corresp">
                <xsl:text>\footnote{[</xsl:text>
                <xsl:value-of select="translate(@corresp, '# ', ' ;')"/>
                <xsl:text>~]~</xsl:text>
                <xsl:choose>
                    <xsl:when test="./tei:hi[@rendition = 'italique']">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="./tei:persName[@type = 'auteur']">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="./tei:hi[@rendition = 'up']">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="./tei:foreign">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
                <!--Si la note est structurelle-->
                <xsl:text>}</xsl:text>
            </xsl:if>
            <xsl:if test="not(@corresp)">
                <xsl:text>\footnote{</xsl:text>
                <xsl:choose>
                    <xsl:when test="./tei:hi[@rendition = 'italique']">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="./tei:persName[@type = 'auteur']">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="./tei:hi[@rendition = 'up']">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="./tei:quote">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="./tei:foreign">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
                <!--Si la note est structurelle-->
                <xsl:text>}</xsl:text>
            </xsl:if>
        </xsl:if>
    </xsl:template>



    <!--A terme remplace les tei:hi pour de l'istruction de mise en page dans les notes-->
    <xsl:template match="tei:foreign">
        <xsl:text>\textit{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    <!--A terme remplace les tei:hi pour de l'istruction de mise en page dans les notes-->

    <!--italique dans les notes-->
    <xsl:template match="tei:hi[@rendition = 'italique']">
        <!--<xsl:if test=".">-->
        <xsl:text>\textit{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
        <!--</xsl:if>-->
    </xsl:template>
    <!--italique dans les notes-->
    <!--exposant dans les notes-->
    <xsl:template match="tei:hi[@rendition = 'up']">
        <!--<xsl:if test=".">-->
        <xsl:text>\textsuperscript{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
        <!--</xsl:if>-->
    </xsl:template>
    <!--exposant dans les notes-->

    <!--Notes en bas de page-->


    <!--Marquer les listes et les item-->
    <xsl:template match="tei:list">
        <xsl:text>\begin{description}</xsl:text>
        <xsl:for-each select="tei:item">
           <!-- <xsl:if test="tei:p[@rend = 'rubriqu�']">
                <xsl:text>\textit{</xsl:text>
                <xsl:apply-templates select="./tei:item/tei:p"/>
                <xsl:text>}</xsl:text>
            </xsl:if>
            <xsl:if test="not(./tei:p)">-->
                <xsl:text>\item </xsl:text>
                <xsl:apply-templates/>
            <!--</xsl:if>-->
        </xsl:for-each>
        <xsl:text>\end{description}~\newline</xsl:text>

    </xsl:template>
    <!--Marquer les listes -->
    <!--MISE EN PAGE-->


    <xsl:template match="tei:catchwords"/>


    <!--AJOUTS-->
    <!--ajouts du copiste en exposant (interlin�aire) ou en note (marge): deuxi�me niveau de 
        notes ou ajout en exposation. Si appartient � un apparat, simple indication avec le 
        terme ajout� en italique-->
    <xsl:template match="tei:add">
        <xsl:if test="not(@place)">
            <xsl:value-of select="."/>
        </xsl:if>
        <xsl:if test="@place = 'inline'">
            <xsl:if test="ancestor::tei:app">
                <xsl:text>\textit{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:if>
        </xsl:if>
        <xsl:if test="@place = 'above'">
            <xsl:text>\textit{</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>}</xsl:text>
        </xsl:if>
        <xsl:if test="@place = 'margin'">
            <!--Si le add est inclus dans un apparat-->
            <xsl:if test="ancestor::tei:app">
                <xsl:choose>
                    <!--Si l'apparat n'est pas un apparat principal mais un apparat de point notables (notable)
                    >> note. On peut accepter la note de bas de page (�viter les notes de bas de page dans un apparat
                    critique...)-->
                    <xsl:when test="(ancestor::tei:app/@type = 'notable')">
                        <xsl:text>\footnote{Ajout� en marge:\textit{</xsl:text>
                        <xsl:apply-templates select="tei:rdg"/>
                        <xsl:text>}}</xsl:text>
                    </xsl:when>
                    <!--Si l'apparat n'est pas un apparat principal mais un apparat de point notables (notable)-->
                    <xsl:otherwise>
                        <xsl:text>[ajout� en marge:\textit{</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>}]</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <!--Si le add est inclus dans un apparat-->
            <xsl:if test="not(ancestor::tei:app)">
                <xsl:text>\footnote{</xsl:text>
                <xsl:if test="@corresp">
                    <xsl:text> [Ms. </xsl:text>
                    <xsl:value-of select="translate(@corresp, '#', '')"/>
                    <xsl:text>] </xsl:text>
                </xsl:if>
                <xsl:text>Ajout� </xsl:text>
                <xsl:text>(marge)</xsl:text>
                <xsl:text>: ``\textit{</xsl:text>
                <xsl:value-of select="text()"/>
                <xsl:text>}''</xsl:text>
                <xsl:if test="@hand">
                    <xsl:text> Main </xsl:text>
                    <xsl:value-of select="translate(@hand, '#', '')"/>
                    <xsl:text>. </xsl:text>
                </xsl:if>
                <xsl:if test="./tei:note">
                    <xsl:value-of select="tei:note"/>
                </xsl:if>
                <xsl:if test="not(@note)"> </xsl:if>
                <xsl:text>}</xsl:text>
            </xsl:if>
        </xsl:if>
        <!--etc-->



    </xsl:template>

    <xsl:template match="tei:ref">
        <xsl:text>\textit{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <!--Les ajouts de ma part sont entre crochets-->
    <xsl:template match="//tei:supplied" name="supplied">
        <xsl:text>&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <!--Les ajouts de ma part sont entre crochets-->
    <!--AJOUTS-->

    <xsl:template match="tei:subst">
        <xsl:apply-templates/>
    </xsl:template>

    <!--MODIFICATIONS CORRECTIONS-->
    <xsl:template match="//tei:space" name="space">
        <xsl:text>\indent</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:lb">
        <xsl:text> // </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:title">
        <xsl:text>\textit{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="tei:unclear" name="unclear">
        <xsl:text>~?</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>?</xsl:text>
    </xsl:template>

    <xsl:template match="tei:choice">
        <xsl:value-of select="tei:corr"/>
        <xsl:value-of select="tei:reg"/>
    </xsl:template>


    <xsl:template match="tei:damage" name="damage">
        <xsl:choose>
            <xsl:when test="text() = ''">
                <xsl:text>&#x2020; &#x2020;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\underline{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:gap">
        <xsl:text>\indent</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- ignorer le text entre balises <del>-->
    <xsl:template match="//tei:del" name="del">
        <xsl:text>[[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]]</xsl:text>
    </xsl:template>
    <!-- ignorer le text entre balises <del>-->




    <!--Foliation en exposant entre crochets -->
    <xsl:template match="tei:pb[@edRef = '#EscKI5']">
        <xsl:text>\textsuperscript{[fol. </xsl:text>
        <xsl:value-of select="@n"/>
        <xsl:text>]}</xsl:text>
    </xsl:template>
    <!--Foliation en exposant entre crochets -->


    <xsl:template match="tei:cb">
        <xsl:text>\textit{[col. b]}</xsl:text>
    </xsl:template>
    <!--Foliation-->

    <xsl:template match="tei:quote">
        <xsl:text>&lt;&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;&gt;</xsl:text>
    </xsl:template>


    <!--APPARAT-->
    <xsl:template name="apparat" match="tei:app">
        <!-- APPARATS � ne pas faire appara�tre-->
        <!--Ponctuation. Suppose de diff�rencier les 
            apparats. Permet de ne pas inclure les diff�rentes ponctuations dans l'apparat-->
        <xsl:choose>
            <xsl:when test="@type = 'negligeable'">
                <xsl:value-of select="tei:lem"/>
            </xsl:when>

            <xsl:when test="@type = 'ponctuation'">
                <xsl:if test="not(tei:lem/tei:choice)">
                    <!--D�commenter et commenter la r�gle suivante si besoin de supprimer les �-->
                    <xsl:value-of select="translate(./tei:lem, '�', '')"/>
                    <!--<xsl:value-of select="./tei:lem"/>-->
                    <!--D�commenter si besoin de supprimer les �-->
                </xsl:if>
                <xsl:if test="./tei:lem/tei:choice">
                    <!--Afficher les corrections et r�gularisations-->

                    <!--D�commenter et commenter la r�gle suivante si besoin de supprimer les �-->
                    <xsl:value-of select="translate(tei:lem/tei:choice/tei:corr, '�', '')"/>
                    <!--<xsl:value-of select="tei:lem/tei:choice/tei:corr"/>-->

                    <xsl:value-of select="tei:lem/tei:choice/tei:reg"/>

                    <!--Afficher les corrections et r�gularisations-->
                </xsl:if>
            </xsl:when>
            <!--Ponctuation. -->
            <!--ne faire apparaitre que le r�sultat des modifications (addition, suppresion, difficult�s de lecture)
                dans le fichier TEX-->
            <xsl:when test="@type = 'notable'">
                <xsl:choose>
                    <!--add dans un lem-->
                    <xsl:when test="./tei:lem/tei:add">
                        <xsl:if test="./tei:lem/text() != ''">
                            <xsl:apply-templates select="./tei:lem"/>
                        </xsl:if>
                        <xsl:if test="not(./tei:lem/text() != '')">
                            <xsl:text>\textit{</xsl:text>
                            <xsl:value-of select="./tei:lem/tei:add"/>
                            <xsl:text>}</xsl:text>
                        </xsl:if>
                    </xsl:when>
                    <xsl:when test="not(./tei:lem/tei:add)">
                        <xsl:value-of select="./tei:lem"/>
                    </xsl:when>
                    <!--add dans un lem-->
                    <!--add dans un rdg-->
                    <xsl:when test="./tei:rdg/tei:add">
                        <xsl:if test="./tei:rdg/text() != ''">
                            <xsl:apply-templates select="./tei:rdg"/>
                        </xsl:if>
                        <xsl:if test="not(./tei:rdg/text() != '')">
                            <xsl:apply-templates/>
                        </xsl:if>
                    </xsl:when>
                    <xsl:when test="not(./tei:rdg/tei:add)"/>
                    <!-- add dans un rdg-->
                </xsl:choose>
            </xsl:when>
            <!--ne faire apparaitre que le r�sultat-->

            <!--ne pas faire apparaitre les variantes orthographiques-->
            <xsl:when test="@type = 'orthographique'">
                <xsl:if test="not(tei:lem/tei:choice)">
                    <xsl:value-of select="./tei:lem"/>
                </xsl:if>
                <xsl:if test="./tei:lem/tei:choice">
                    <xsl:value-of select="tei:lem/tei:choice/tei:corr"/>
                </xsl:if>
            </xsl:when>
            <!--ne pas faire apparaitre les apparats orthographiques et autres-->
            <!-- APPARATS � ne pas faire appara�tre-->



            <!--APPARATS � faire appara�tre-->
            <!--Lacunes: suppose de distinguer entre une lacune (trou dans le texte <<anormal>>) et
                le d�but d'un t�moin qui peut �tre plus court que les autres. Pour ce faire, j'utilise 
                les balises <lacunaStart>, <lacunaEnd> et <witStart>/<witEnd> Je les place dans des app/rdg pour les 
                lier � un t�moins pr�cis.-->

            <xsl:when test="@type = 'structure'">


                <!--!!!!!!Trouver un moyen de faire appara�tre l'indication de lacunes
                    qui sont encod�es dans le m�me app
                SOLUTION: 
                A)deux rdg avec la m�me indication de lacune peuvent �tre fondus
                en un rdg avec deux valeurs d'attribut wit. 
                >>>>Second probl�me: deux indications 
                au m�me niveau sont rendues en superposition avec \marginpar...<<<<<
                DONC: proposer un truc du genre: 
                - si le nombre d'�lements de wit=1 > \note{Wit... commence/s'arr�te ici}
                - si le nombre d'�l�ments de wit>1 \note{Wit a ET Wit b commencENT\s'arr�tENT ici}
                A FAIRE
                B)deux rdg avec deux indications de lacune diff�rente, �a marche bien.-->
                <!--Dans LaTex, les lacunes apparaissent en note de marge. Si une note les accompagne, elle sera plac�e dans
                le premier niveau de notes ("structure")-->
                <xsl:if test="tei:rdg/tei:lacunaStart">
                    <xsl:text>*\marginpar{\textit{[*D�but de lacune pour \textit{</xsl:text>
                    <xsl:value-of select="translate(tei:rdg/@wit, '# ', ' ;')"/>
                    <xsl:text>} </xsl:text>
                    <!--Permet d'annoter et de commenter le d�but d'une lacune-->
                    <xsl:if test="tei:rdg/tei:lacunaStart/following-sibling::tei:note">
                        <xsl:text>\footnotemark.]}} \footnotetext{</xsl:text>
                        <!--[ <xsl:value-of
                            select="translate(tei:rdg/@wit, '# ', ' ;')"/> ]-->
                        <xsl:value-of select="tei:rdg/tei:note"/>
                        <xsl:text>}</xsl:text>
                    </xsl:if>
                    <!--Permet d'annoter et de commenter le d�but d'une lacune-->
                    <xsl:if test="not(tei:rdg/tei:lacunaStart/following-sibling::tei:note)">
                        <xsl:text>.]}}</xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="tei:rdg/tei:lacunaEnd">
                    <xsl:text>*\marginpar{\textit{[*Fin de lacune pour \textit{</xsl:text>
                    <xsl:value-of select="translate(tei:rdg/@wit, '# ', ' ;')"/>
                    <xsl:text>} </xsl:text>
                    <!--Permet d'annoter et de commenter la fin d'une lacune-->
                    <xsl:if test="tei:rdg/tei:lacunaEnd/following-sibling::tei:note">
                        <xsl:text>\footnotemark.]}} \footnotetext{</xsl:text> [ <xsl:value-of
                            select="translate(tei:rdg/@wit, '# ', ' ;')"/> ] <xsl:value-of
                            select="tei:rdg/tei:note"/>
                        <xsl:text>}</xsl:text>
                    </xsl:if>
                    <!--Permet d'annoter et de commenter la fin d'une lacune-->
                    <xsl:if test="not(tei:rdg/tei:lacunaEnd/following-sibling::tei:note)">
                        <xsl:text>.]}}</xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="tei:rdg/tei:witStart">
                    <xsl:text>*\marginpar{\textit{[*\textit{</xsl:text>
                    <xsl:value-of select="translate(tei:rdg/@wit, '# ', ' ;')"/>
                    <xsl:text>} commence ici</xsl:text>
                    <!--Permet d'annoter et de commenter le d�but d'un t�moin-->
                    <xsl:if test="tei:rdg/tei:witStart/following-sibling::tei:note">
                        <xsl:text>\footnotemark.]}} \footnotetext{</xsl:text> [ <xsl:value-of
                            select="translate(tei:rdg/tei:note/@corresp, '# ', ' ;')"/> ]
                            <xsl:value-of select="tei:rdg/tei:note"/>
                        <xsl:text>}</xsl:text>
                    </xsl:if>
                    <!--Permet d'annoter et de commenter le d�but d'un t�moin-->
                    <xsl:if test="not(tei:rdg/tei:witStart/following-sibling::tei:note)">
                        <xsl:text>.]}}</xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="tei:rdg/tei:witEnd">
                    <xsl:text>*\marginpar{\textit{[*\textit{</xsl:text>
                    <xsl:value-of select="translate(tei:rdg/@wit, '# ', ' ;')"/>
                    <xsl:text>} s'arr�te ici</xsl:text>
                    <!--Permet d'annoter et de commenter la fin d'un t�moin-->
                    <xsl:if test="tei:rdg/tei:witEnd/following-sibling::tei:note">
                        <xsl:text>\footnotemark.]}} \footnotetext{</xsl:text> [ <xsl:value-of
                            select="translate(tei:rdg/@wit, '# ', ' ;')"/> ] <xsl:value-of
                            select="tei:rdg/tei:note"/>
                        <xsl:text>}</xsl:text>
                    </xsl:if>
                    <!--Permet d'annoter et de commenter la fin d'un t�moin-->
                    <xsl:if test="not(tei:rdg/tei:witEnd/following-sibling::tei:note)">
                        <xsl:text>.]}}</xsl:text>
                    </xsl:if>
                </xsl:if>
            </xsl:when>
            <!--Dans LaTex, les lacunes apparaissent en note de marge. Si une note les accompagne, elle sera plac�e dans
                le premier niveau de notes ("structure")-->
            <!--Lacunes-->

            <!--apparat de lemmes significatifs-->
            <xsl:when test="@type = 'lemmes'">
                <xsl:text> \Anote{ </xsl:text>
                <xsl:if test="not(tei:lem/tei:choice)">
                    <xsl:choose>
                        <xsl:when test="tei:lem/tei:note">
                            <xsl:apply-templates select="./tei:lem"/>
                        </xsl:when>
                        <!-- test: UNCLEAR entre crochets avec -->
                        <xsl:when test="./tei:lem/tei:unclear">
                            <xsl:if test="./tei:lem/text() != ''">
                                <xsl:apply-templates select="./tei:lem"/>
                            </xsl:if>
                            <xsl:if test="not(./tei:lem/text() != '')">
                                <xsl:apply-templates select="./tei:lem"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:when test="not(./tei:lem/tei:unclear)">
                            <xsl:apply-templates select="./tei:lem"/>
                        </xsl:when>
                    </xsl:choose>
                    <!-- test: UNCLEAR entre crochets avec un ?-->
                </xsl:if>
                <xsl:if test="./tei:lem/tei:choice">
                    <xsl:if test="./tei:lem/text() != ''">
                        <xsl:apply-templates select="./tei:lem"/>
                    </xsl:if>
                    <xsl:if test="not(./tei:lem/text() != '')">
                        <xsl:apply-templates select="tei:lem"/>
                    </xsl:if>
                </xsl:if>
                <xsl:text>}{</xsl:text>
                <xsl:text>\textit{</xsl:text>
                <xsl:value-of select="translate(tei:lem/@wit, '# ', '')"/>
                <xsl:text>};~</xsl:text>
                <xsl:for-each select="tei:rdg">

                    <!--Omission:copi� de la feuille de MB-->
                    <xsl:choose>
                        <!--Quand catchwords (Attention bient�t obsol�te)-->
                        <xsl:when test="./tei:catchwords">
                            <xsl:apply-templates/> ~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Quand catchwords-->
                        <!--Si il y a un subst avec ou sans texte brut-->
                        <xsl:when test="./tei:subst">
                            <xsl:if test="text() != ''">
                                <xsl:apply-templates select="."/>
                            </xsl:if>
                            <xsl:if test="not(text() != '')">
                                <xsl:apply-templates/></xsl:if>~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Si il y a un subst-->
                        <!--Si il y a un unclear avec ou sans texte brut-->
                        <xsl:when test="./tei:unclear">
                            <xsl:if test="text() != ''">
                                <xsl:apply-templates select="."/>
                            </xsl:if>
                            <xsl:if test="not(text() != '')">
                                <xsl:apply-templates/></xsl:if>~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Si il y a un unclear-->
                        <!--Si il y a un hi-->
                        <xsl:when test="./tei:hi">
                            <xsl:if test="text() != ''">
                                <xsl:apply-templates select="."/>
                            </xsl:if>
                            <xsl:if test="not(text() != '')">
                                <xsl:apply-templates/></xsl:if>~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Si il y a un hi-->
                        <!--Si il y a un gap avec ou sans texte brut-->
                        <xsl:when test="./tei:gap">
                            <xsl:if test="text() != ''">
                                <xsl:apply-templates select="."/>
                            </xsl:if>
                            <xsl:if test="not(text() != '')">
                                <xsl:apply-templates/></xsl:if>~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Si il y a un gap-->
                        <!--Si il y a un damage avec ou sans texte brut-->
                        <xsl:when test="./tei:damage">
                            <xsl:if test="text() != ''">
                                <xsl:apply-templates select="."/>
                            </xsl:if>
                            <xsl:if test="not(text() != '')">
                                <xsl:apply-templates/></xsl:if>~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Si il y a un damage-->
                        <!--Si il y a un space avec ou sans texte brut-->
                        <xsl:when test="./tei:space">
                            <xsl:if test="text() != ''">
                                <xsl:apply-templates select="."/>
                            </xsl:if>
                            <xsl:if test="not(text() != '')">
                                <xsl:apply-templates/></xsl:if>~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Si il y a un space-->
                        <!--Si il y a un del avec ou sans texte brut-->
                        <xsl:when test="./tei:del">
                            <xsl:if test="text() != ''">
                                <xsl:apply-templates select="."/>
                            </xsl:if>
                            <xsl:if test="not(text() != '')">
                                <xsl:apply-templates/></xsl:if>~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Si il y a un del-->
                        <!--Si il y a un supplied avec ou sans texte brut-->
                        <xsl:when test="./tei:supplied">
                            <xsl:if test="text() != ''">
                                <xsl:apply-templates select="."/>
                            </xsl:if>
                            <xsl:if test="not(text() != '')">
                                <xsl:apply-templates/></xsl:if>~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Si il y a un supplied-->
                        <!--Si il y a un add avec ou sans texte brut-->
                        <xsl:when test="./tei:add">
                            <xsl:if test="text() != ''">
                                <xsl:text>~</xsl:text><xsl:apply-templates select="."/>
                            </xsl:if>
                            <xsl:if test="not(text() != '')">
                                <xsl:text>~</xsl:text><xsl:apply-templates/></xsl:if>~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Si il y a un add-->
                        <xsl:when test="text() != ''"><xsl:text>~</xsl:text>
                            <xsl:apply-templates select="."/> \textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                            <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                        </xsl:when>
                        <xsl:otherwise> \textit{om. <xsl:value-of select="translate(@wit, '#', '')"
                            />} <!--s�pare deux le�ons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                            <!--s�pare deux le�ons concomittantes par un ; si elles existent--></xsl:otherwise>
                    </xsl:choose>
                    <!--Omission:copi� de la feuille de marjorie-->
                    <!--Faire la m�me chose avec les additions-->
                </xsl:for-each>
                <xsl:text>} </xsl:text>
            </xsl:when>
        </xsl:choose>
        <!--apparat de lemmes significatifs-->
        <!--APPARATS � faire appara�tre-->
    </xsl:template>
    <!--APPARAT-->

    <!--STRUCTURE DU TEXTE-->




    <xsl:template match="tei:div1[@type = 'Prologue']">
        <xsl:if test="@n = '1'">
            <xsl:text>
            \subsubsection{[Premier prologue]}</xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:if test="@n = '2'">
            <xsl:text>
            \subsubsection{[Second prologue]}</xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
        <!--etc..-->
    </xsl:template>

    <!--Tables de mati�res-->
    <xsl:template match="tei:div1[@type = 'TableG']">
        <xsl:text>
            \subsubsection{[Table des mati�res]}</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:div3[@type = 'TableP']">
        <xsl:text>
            \paragraph{[Table des mati�res]}</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <!--Tables de mati�res-->



    <xsl:template match="tei:div2[@type = 'Lettre']">
        <xsl:text>
            \subsubsection{[Lettre de Gilles de Rome � Philippe le Bel]}</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <!--Choisir et marquer le chapitre-->
    <xsl:template match="tei:div3[@type = 'Chapitre']">
        <xsl:text> \end{linenumbers}
            \renewcommand\linenumberfont{\normalfont\mdseries\footnotesize}
            <!--~\newpage-->~\newpage
            ~\newline\newline\newline\newline\newline\newline\newline
            \subsubsection{[Chapitre </xsl:text>
        <xsl:value-of select="@n"/>
        <xsl:text>]}
            \begin{linenumbers}[1] </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <!--Choisir et marquer le chapitre-->

    <!--Choisir et marquer la glose/traduction-->
    <xsl:template match="tei:div4[@type = 'Traduction']">
        <xsl:text>
            \paragraph{[Traduction]}~\newline\newline </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:div4[@type = 'Glose']">
        <xsl:text>
            \paragraph{[Glose]}~\newline\newline </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <!--Choisir et marquer la glose/traduction-->



    <!--Choisir et marquer la partie-->
    <xsl:template match="tei:div2[@type = 'Partie']">
        <xsl:if test="@n = '1'">
            <xsl:text>
            ~\newpage\section{Premi�re partie}</xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:if test="@n = '2'">
            <xsl:text>
            ~\newpage\section{Seconde partie}</xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:if test="@n = '3'">
            <xsl:text>
            ~\newpage\section{Troisi�me partie}</xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:if test="@n = '4'">
            <xsl:text>
            ~\newpage\section{Quatri�me partie}</xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    <!--Choisir et marquer la Partie-->

    <!--STRUCTURE DU TEXTE-->

    <!--MISE EN PAGE-->
    <!--Marquer les paragraphes par un retour � la ligne-->
    <xsl:template match="tei:p">
        <xsl:apply-templates/>
        <xsl:text>
            
            
        </xsl:text>
    </xsl:template>
    <!--Marquer les paragraphes par un retour � la ligne-->

    <!--Marquer les titres par un retour � la ligne-->
    <!--A FAIREint�grer les app et les choice dans les head!-->
    <xsl:template match="tei:head">
        <xsl:text>\textit{</xsl:text>
        <xsl:if test="./tei:app">
            <xsl:if test="tei:head/text() != ''">
                <xsl:apply-templates select="."/>
            </xsl:if>
            <xsl:if test="not(tei:head/text() != '')">
                <xsl:apply-templates/>
            </xsl:if>
        </xsl:if>
        <xsl:if test="not(./tei:app)">
            <xsl:if test="text() != ''">
                <xsl:apply-templates/>
            </xsl:if>
            <xsl:if test="not(text() != '')">
                <xsl:apply-templates/>
            </xsl:if>
        </xsl:if>
        <xsl:text>}</xsl:text>
        <xsl:text>~\\
            
            
        </xsl:text>
    </xsl:template>
    <!--Marquer les titres par un retour � la ligne-->

    <xsl:template match="text()">
        <xsl:variable name="sub1" select="replace(., ' e ', ' \\&amp; ')"/>
        <!--Faire la m�me chose avec les guillemets ouvrants et fermants-->
        <xsl:variable name="sub2" select="replace($sub1, '-', '--')"/>
        <xsl:variable name="sub3" select="replace($sub2, '\.', '. ')"/>
        <xsl:variable name="sub4" select="replace($sub3, ' \. ', '.')"/>
        <xsl:variable name="sub5" select="replace($sub4, ' ,', ',')"/>
        <xsl:variable name="sub6" select="replace($sub5, ';', ';~')"/>
        <xsl:variable name="sub7" select="replace($sub6, '~~', '~')"/>
        <xsl:variable name="sub8" select="replace($sub7, '~ ', '~')"/>
        <xsl:variable name="sub9" select="replace($sub8, ' mente', 'mente')"/>
        <!--Permet de cibler les notes de bas de page et de laisser les espaces pour l'italique p.e-->
        <xsl:variable name="sub10" select="replace($sub9, ' \\foot', '\\foot')"/>
        <!--Permet de cibler les notes de bas de page et de laisser les espaces pour l'italique p.e-->
        <xsl:value-of select="$sub10"/>
    </xsl:template>

</xsl:stylesheet>
