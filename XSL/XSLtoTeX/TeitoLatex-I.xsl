<?xml version="1.0" encoding="ISO-8859-1"?>
<!--PROBLEMES-->
<!--REFAIRE LES REGLES D AJOUTS EN MARGE-->
<!--notable: tout ce qui est notable (renommer le type)-->
<!--Intégrer les notes dans un apparat de lemmes...-->
<!--Régulariser les différences dans les add entre above et pas above-->

<!-- IDEE: Gérer les modifications textuelles: Et si je faisais ma transformation en deux temps? D'abord, toutes les grosses transformations EN GARDANT UNE STRUCTURE XML BASIQUE
    et bien formée (une déclaration d'entité, etc) Sur cette transformation, en faire une seconde qui va supprimer tout ce qui est xml et garder que le texte ET qui 
pourra modifier les espaces simplement (translate ou un autre truc) ainsi qu'adapter les détails à LaTeX, comme les - - qui donne un tiret correct, ou transformer tous les e en &, etc-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:tex="placeholder.uri"
    exclude-result-prefixes="tex">
    <!--Le but recherché avec cette feuille est la création de l'édition critique à partir d'un 
        manuscrit, ici le Ms. K.I.5 de la Bibliothèque de l'Escorial, avec apparat positif-->
    <!--ATTENTION: Cette feuille XSL ppermet de transformer l'édition critique .xml en document Tex NON COMPILABLE:
        le résultat sera uniquement le texte, les notes, et l'apparat.-->
    <!--RECOMMANDÉ: la feuille xsl est construite pour une utilisation du document .tex comme annexe 
        vers laquelle pointe le document principal (utilisant \input{...} par exemple).-->
    <!--IMPÉRATIF: Le package latex utilisé pour l'apparat est ednotes (https://www.ctan.org/pkg/ednotes). 
    Il doit impérativement être accompagné du package lineno (https://www.ctan.org/pkg/lineno)
    et du package manyfoot (https://www.ctan.org/pkg/manyfoot) pour 
    les différents niveaux de notes 
    (\DeclareNewFootnote{B}[arabic]
\usepackage{perpage}
\MakePerPage{footnote}
\renewcommand{\thefootnote}{\alph{footnote}} pour adapter le préambule LaTex à la feuille de transformation)
    , ainsi que du package marginpar (https://www.ctan.org/pkg/marginpar)
    pour permettre l'indication en marge des lacunes et des commencements/fins de témoins-->
    <!--Je propose mon preambule LaTex à l'adresse: http://perso.ens-lyon.fr/matthias.gille-levenson/preambule.txt. 
    Si le lien est périmé, me contacter sur mon adresse ens: matthias.gille-levenson[arobase]ens[point]fr -->
    <!--Cette feuille est adaptée à mon propre document XML-->
    <!--Merci à Arianne Pinche pour son aide précieuse dans cette feuille-->
    <!--Merci à Marjorie Burghart de m'avoir envoyé sa feuille de transformation qui m'a bien aidé-->
    <xsl:output method="xml" omit-xml-declaration="no" encoding="ISO-8859-1"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="fr">
            <text>
                <xsl:text>
        \vfill\vfill
        \noindent\textit{La foliation concerne uniquement le} codex optimus, \textit{pour l'instant KI5}.\newline
        ~\newline\underline{Apparat}\newline\newline
         Pour des raisons de temps, mon apparat n'est pas le plus académiquement conforme. Comme suit:\newline\newline
        \fbox{\begin{minipage}{1\textwidth}
     \begin{center}
         \textbf{n. de la ligne} lemme ] \textit{témoin du lemme} ; leçon(s) rejetée(s) ; \textit{témoin(s)}
     \end{center}
\end{minipage}}~\newline\newline
        \textit{Les ajouts éditoriaux sont indiqués entre crochets &lt; &gt;.\newline 
        Les suppressions du copistes sont indiquées par le biais de crochets doubles [[ ]].\newline 
        Les ajouts du copistes sont indiqués en italique.\newline
        Les passages illisibles sont indiqués par un espace de tabulation. \newline
        J'indique par un [ø] l'absence d'un mot dans une leçon.\newline
        Entre deux signes d'interrogation ? ?, les mots difficiles à lire.\newline
        Les passages endommagés sont \underline{soulignés}.\newline
        Ainsi par exemple, un apparat qui propose le mot suivant: }ve?[[r]]\textit{n}?g?[[ue]]\textit{a}?nça \textit{signifie que l'on se trouve devant un 
        mot \textit{verguença} qui a probablement été corrigé en \textit{vengança} sans que la correction soit absolument certaine. \newline
        Les espaces qui apparaissent dans l'apparat sont signifiants: ils témoignent d'un espace dans le texte.\newline
        REVOIR POUR LES LACUNES ET LES TROU.\newline
        Je dois dans certains cas faire référence au changement de ligne: il sera indiqué par une double barre oblique //. }\newline\newline
        \underline{Fonctionnement des notes}\newline\newline
        Je propose quatre niveaux de notes: les notes de marge les lacunes et les arrêts/reprises des différents témoins.
        Vient ensuite le premier niveau de notes, alphabétique, (notes concernant les témoins en général), les notes d'apparat, 
        et enfin les notes de 
        commentaire thématique. 
       \vfill\vfill\vfill ~\newpage
       
       </xsl:text>
                <xsl:text>\textbf{Sigles des témoins}\newline\newline</xsl:text>
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

    <!-- Mettre en valeur tous les lemmes qui ne sont pas tirés du codex optimus-->
    <xsl:template match="./tei:lem[not(contains(concat(' ', @wit, ' '), ' #Q '))]">
        <xsl:text>\textbf{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    <!-- Mettre en valeur tous les lemmes qui ne sont pas tirés du codex optimus-->



    <!--Notes en bas de page. -->
    <!--Est ce que je me complique pas la vie à écrire deux fois les mêmes règles?-->
    <!--Si la note est thématique, second niveau de notes, appel en chiffres arabes-->
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
        <!--Si la note est thématique-->
        <!--Si la note est structurelle (description d'un témoin dans sa matérialité),
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
           <!-- <xsl:if test="tei:p[@rend = 'rubriqué']">
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
    <!--ajouts du copiste en exposant (interlinéaire) ou en note (marge): deuxième niveau de 
        notes ou ajout en exposation. Si appartient à un apparat, simple indication avec le 
        terme ajouté en italique-->
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
                    >> note. On peut accepter la note de bas de page (éviter les notes de bas de page dans un apparat
                    critique...)-->
                    <xsl:when test="(ancestor::tei:app/@type = 'notable')">
                        <xsl:text>\footnote{Ajouté en marge:\textit{</xsl:text>
                        <xsl:apply-templates select="tei:rdg"/>
                        <xsl:text>}}</xsl:text>
                    </xsl:when>
                    <!--Si l'apparat n'est pas un apparat principal mais un apparat de point notables (notable)-->
                    <xsl:otherwise>
                        <xsl:text>[ajouté en marge:\textit{</xsl:text>
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
                <xsl:text>Ajouté </xsl:text>
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
        <!-- APPARATS à ne pas faire apparaître-->
        <!--Ponctuation. Suppose de différencier les 
            apparats. Permet de ne pas inclure les différentes ponctuations dans l'apparat-->
        <xsl:choose>
            <xsl:when test="@type = 'negligeable'">
                <xsl:value-of select="tei:lem"/>
            </xsl:when>

            <xsl:when test="@type = 'ponctuation'">
                <xsl:if test="not(tei:lem/tei:choice)">
                    <!--Décommenter et commenter la règle suivante si besoin de supprimer les ¶-->
                    <xsl:value-of select="translate(./tei:lem, '¶', '')"/>
                    <!--<xsl:value-of select="./tei:lem"/>-->
                    <!--Décommenter si besoin de supprimer les ¶-->
                </xsl:if>
                <xsl:if test="./tei:lem/tei:choice">
                    <!--Afficher les corrections et régularisations-->

                    <!--Décommenter et commenter la règle suivante si besoin de supprimer les ¶-->
                    <xsl:value-of select="translate(tei:lem/tei:choice/tei:corr, '¶', '')"/>
                    <!--<xsl:value-of select="tei:lem/tei:choice/tei:corr"/>-->

                    <xsl:value-of select="tei:lem/tei:choice/tei:reg"/>

                    <!--Afficher les corrections et régularisations-->
                </xsl:if>
            </xsl:when>
            <!--Ponctuation. -->
            <!--ne faire apparaitre que le résultat des modifications (addition, suppresion, difficultés de lecture)
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
            <!--ne faire apparaitre que le résultat-->

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
            <!-- APPARATS à ne pas faire apparaître-->



            <!--APPARATS à faire apparaître-->
            <!--Lacunes: suppose de distinguer entre une lacune (trou dans le texte <<anormal>>) et
                le début d'un témoin qui peut être plus court que les autres. Pour ce faire, j'utilise 
                les balises <lacunaStart>, <lacunaEnd> et <witStart>/<witEnd> Je les place dans des app/rdg pour les 
                lier à un témoins précis.-->

            <xsl:when test="@type = 'structure'">


                <!--!!!!!!Trouver un moyen de faire apparaître l'indication de lacunes
                    qui sont encodées dans le même app
                SOLUTION: 
                A)deux rdg avec la même indication de lacune peuvent être fondus
                en un rdg avec deux valeurs d'attribut wit. 
                >>>>Second problème: deux indications 
                au même niveau sont rendues en superposition avec \marginpar...<<<<<
                DONC: proposer un truc du genre: 
                - si le nombre d'élements de wit=1 > \note{Wit... commence/s'arrête ici}
                - si le nombre d'éléments de wit>1 \note{Wit a ET Wit b commencENT\s'arrêtENT ici}
                A FAIRE
                B)deux rdg avec deux indications de lacune différente, ça marche bien.-->
                <!--Dans LaTex, les lacunes apparaissent en note de marge. Si une note les accompagne, elle sera placée dans
                le premier niveau de notes ("structure")-->
                <xsl:if test="tei:rdg/tei:lacunaStart">
                    <xsl:text>*\marginpar{\textit{[*Début de lacune pour \textit{</xsl:text>
                    <xsl:value-of select="translate(tei:rdg/@wit, '# ', ' ;')"/>
                    <xsl:text>} </xsl:text>
                    <!--Permet d'annoter et de commenter le début d'une lacune-->
                    <xsl:if test="tei:rdg/tei:lacunaStart/following-sibling::tei:note">
                        <xsl:text>\footnotemark.]}} \footnotetext{</xsl:text>
                        <!--[ <xsl:value-of
                            select="translate(tei:rdg/@wit, '# ', ' ;')"/> ]-->
                        <xsl:value-of select="tei:rdg/tei:note"/>
                        <xsl:text>}</xsl:text>
                    </xsl:if>
                    <!--Permet d'annoter et de commenter le début d'une lacune-->
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
                    <!--Permet d'annoter et de commenter le début d'un témoin-->
                    <xsl:if test="tei:rdg/tei:witStart/following-sibling::tei:note">
                        <xsl:text>\footnotemark.]}} \footnotetext{</xsl:text> [ <xsl:value-of
                            select="translate(tei:rdg/tei:note/@corresp, '# ', ' ;')"/> ]
                            <xsl:value-of select="tei:rdg/tei:note"/>
                        <xsl:text>}</xsl:text>
                    </xsl:if>
                    <!--Permet d'annoter et de commenter le début d'un témoin-->
                    <xsl:if test="not(tei:rdg/tei:witStart/following-sibling::tei:note)">
                        <xsl:text>.]}}</xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="tei:rdg/tei:witEnd">
                    <xsl:text>*\marginpar{\textit{[*\textit{</xsl:text>
                    <xsl:value-of select="translate(tei:rdg/@wit, '# ', ' ;')"/>
                    <xsl:text>} s'arrête ici</xsl:text>
                    <!--Permet d'annoter et de commenter la fin d'un témoin-->
                    <xsl:if test="tei:rdg/tei:witEnd/following-sibling::tei:note">
                        <xsl:text>\footnotemark.]}} \footnotetext{</xsl:text> [ <xsl:value-of
                            select="translate(tei:rdg/@wit, '# ', ' ;')"/> ] <xsl:value-of
                            select="tei:rdg/tei:note"/>
                        <xsl:text>}</xsl:text>
                    </xsl:if>
                    <!--Permet d'annoter et de commenter la fin d'un témoin-->
                    <xsl:if test="not(tei:rdg/tei:witEnd/following-sibling::tei:note)">
                        <xsl:text>.]}}</xsl:text>
                    </xsl:if>
                </xsl:if>
            </xsl:when>
            <!--Dans LaTex, les lacunes apparaissent en note de marge. Si une note les accompagne, elle sera placée dans
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

                    <!--Omission:copié de la feuille de MB-->
                    <xsl:choose>
                        <!--Quand catchwords (Attention bientôt obsolète)-->
                        <xsl:when test="./tei:catchwords">
                            <xsl:apply-templates/> ~\textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
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
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
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
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
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
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
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
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
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
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
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
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
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
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
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
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
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
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                        </xsl:when>
                        <!--Si il y a un add-->
                        <xsl:when test="text() != ''"><xsl:text>~</xsl:text>
                            <xsl:apply-templates select="."/> \textit{<xsl:value-of
                                select="translate(@wit, '# ', '')"/>} <!--sépare deux leçons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                            <!--sépare deux leçons concomittantes par un ; si elles existent-->
                        </xsl:when>
                        <xsl:otherwise> \textit{om. <xsl:value-of select="translate(@wit, '#', '')"
                            />} <!--sépare deux leçons concomittantes par un ; si elles existent-->
                            <xsl:if test="following-sibling::tei:rdg"
                                ><xsl:text>;~</xsl:text></xsl:if>
                            <!--sépare deux leçons concomittantes par un ; si elles existent--></xsl:otherwise>
                    </xsl:choose>
                    <!--Omission:copié de la feuille de marjorie-->
                    <!--Faire la même chose avec les additions-->
                </xsl:for-each>
                <xsl:text>} </xsl:text>
            </xsl:when>
        </xsl:choose>
        <!--apparat de lemmes significatifs-->
        <!--APPARATS à faire apparaître-->
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

    <!--Tables de matières-->
    <xsl:template match="tei:div1[@type = 'TableG']">
        <xsl:text>
            \subsubsection{[Table des matières]}</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:div3[@type = 'TableP']">
        <xsl:text>
            \paragraph{[Table des matières]}</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <!--Tables de matières-->



    <xsl:template match="tei:div2[@type = 'Lettre']">
        <xsl:text>
            \subsubsection{[Lettre de Gilles de Rome à Philippe le Bel]}</xsl:text>
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
            ~\newpage\section{Première partie}</xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:if test="@n = '2'">
            <xsl:text>
            ~\newpage\section{Seconde partie}</xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:if test="@n = '3'">
            <xsl:text>
            ~\newpage\section{Troisième partie}</xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:if test="@n = '4'">
            <xsl:text>
            ~\newpage\section{Quatrième partie}</xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    <!--Choisir et marquer la Partie-->

    <!--STRUCTURE DU TEXTE-->

    <!--MISE EN PAGE-->
    <!--Marquer les paragraphes par un retour à la ligne-->
    <xsl:template match="tei:p">
        <xsl:apply-templates/>
        <xsl:text>
            
            
        </xsl:text>
    </xsl:template>
    <!--Marquer les paragraphes par un retour à la ligne-->

    <!--Marquer les titres par un retour à la ligne-->
    <!--A FAIREintégrer les app et les choice dans les head!-->
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
    <!--Marquer les titres par un retour à la ligne-->

    <xsl:template match="text()">
        <xsl:variable name="sub1" select="replace(., ' e ', ' \\&amp; ')"/>
        <!--Faire la même chose avec les guillemets ouvrants et fermants-->
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
