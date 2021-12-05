
Require Import NArith.BinNat.
Require Import NArith.BinNatDef.


Infix "::" := cons (at level 60, right associativity).
Notation "[ ]" := nil (format "[ ]").
Notation "[ x ]" := (cons x nil).
Notation "[ x ; y ; .. ; z ]" := (cons x (cons y .. (cons z nil) ..)).

Definition test_input := [
  35%N ;
  20%N ;
  15%N ;
  25%N ;
  47%N ;
  40%N ;
  62%N ;
  55%N ;
  65%N ;
  95%N ;
  102%N ;
  117%N ;
  150%N ;
  182%N ;
  127%N ;
  219%N ;
  299%N ;
  277%N ;
  309%N ;
  576%N
  ].

Definition input := [
  17%N ;
  42%N ;
  18%N ;
  39%N ;
  1%N ;
  16%N ;
  13%N ;
  31%N ;
  35%N ;
  32%N ;
  47%N ;
  11%N ;
  40%N ;
  23%N ;
  29%N ;
  30%N ;
  3%N ;
  38%N ;
  43%N ;
  27%N ;
  41%N ;
  9%N ;
  19%N ;
  14%N ;
  46%N ;
  44%N ;
  4%N ;
  20%N ;
  5%N ;
  6%N ;
  10%N ;
  7%N ;
  12%N ;
  17%N ;
  8%N ;
  13%N ;
  25%N ;
  11%N ;
  37%N ;
  49%N ;
  15%N ;
  16%N ;
  22%N ;
  21%N ;
  18%N ;
  23%N ;
  24%N ;
  32%N ;
  19%N ;
  9%N ;
  14%N ;
  26%N ;
  27%N ;
  20%N ;
  76%N ;
  28%N ;
  29%N ;
  36%N ;
  30%N ;
  31%N ;
  33%N ;
  38%N ;
  42%N ;
  34%N ;
  57%N ;
  25%N ;
  58%N ;
  40%N ;
  37%N ;
  44%N ;
  50%N ;
  82%N ;
  109%N ;
  47%N ;
  23%N ;
  71%N ;
  45%N ;
  81%N ;
  75%N ;
  55%N ;
  48%N ;
  54%N ;
  70%N ;
  53%N ;
  61%N ;
  56%N ;
  60%N ;
  69%N ;
  85%N ;
  84%N ;
  94%N ;
  105%N ;
  87%N ;
  67%N ;
  141%N ;
  107%N ;
  123%N ;
  101%N ;
  83%N ;
  76%N ;
  216%N ;
  142%N ;
  103%N ;
  130%N ;
  121%N ;
  109%N ;
  165%N ;
  143%N ;
  136%N ;
  116%N ;
  224%N ;
  187%N ;
  160%N ;
  151%N ;
  150%N ;
  154%N ;
  183%N ;
  226%N ;
  159%N ;
  330%N ;
  177%N ;
  184%N ;
  185%N ;
  192%N ;
  179%N ;
  295%N ;
  212%N ;
  282%N ;
  225%N ;
  230%N ;
  328%N ;
  339%N ;
  266%N ;
  252%N ;
  267%N ;
  362%N ;
  301%N ;
  304%N ;
  305%N ;
  329%N ;
  414%N ;
  429%N ;
  549%N ;
  336%N ;
  363%N ;
  356%N ;
  369%N ;
  391%N ;
  371%N ;
  404%N ;
  641%N ;
  494%N ;
  905%N ;
  455%N ;
  572%N ;
  518%N ;
  621%N ;
  785%N ;
  519%N ;
  705%N ;
  1424%N ;
  605%N ;
  665%N ;
  734%N ;
  685%N ;
  909%N ;
  888%N ;
  727%N ;
  692%N ;
  973%N ;
  760%N ;
  740%N ;
  1118%N ;
  974%N ;
  922%N ;
  1099%N ;
  949%N ;
  1027%N ;
  1258%N ;
  1184%N ;
  2398%N ;
  1211%N ;
  1224%N ;
  1124%N ;
  2006%N ;
  1270%N ;
  1290%N ;
  1419%N ;
  2335%N ;
  1377%N ;
  1432%N ;
  1452%N ;
  1649%N ;
  2297%N ;
  1500%N ;
  1864%N ;
  2426%N ;
  2160%N ;
  1871%N ;
  2021%N ;
  2283%N ;
  2414%N ;
  2809%N ;
  3885%N ;
  2308%N ;
  2348%N ;
  2394%N ;
  2494%N ;
  3430%N ;
  3398%N ;
  2709%N ;
  2667%N ;
  2796%N ;
  5385%N ;
  3797%N ;
  4840%N ;
  3101%N ;
  4167%N ;
  3364%N ;
  3371%N ;
  3735%N ;
  6379%N ;
  3892%N ;
  5079%N ;
  9750%N ;
  4842%N ;
  4656%N ;
  4702%N ;
  4742%N ;
  5015%N ;
  7902%N ;
  4888%N ;
  5203%N ;
  5505%N ;
  8486%N ;
  5376%N ;
  5463%N ;
  5897%N ;
  14281%N ;
  8594%N ;
  6993%N ;
  6465%N ;
  8252%N ;
  6735%N ;
  7263%N ;
  10785%N ;
  8548%N ;
  8634%N ;
  9358%N ;
  16886%N ;
  9544%N ;
  9444%N ;
  16351%N ;
  9630%N ;
  9903%N ;
  11273%N ;
  10091%N ;
  13837%N ;
  18725%N ;
  10839%N ;
  20688%N ;
  11360%N ;
  18138%N ;
  13200%N ;
  17182%N ;
  26772%N ;
  13728%N ;
  15515%N ;
  22558%N ;
  15811%N ;
  19333%N ;
  17906%N ;
  17992%N ;
  18902%N ;
  20383%N ;
  29352%N ;
  35907%N ;
  37870%N ;
  19721%N ;
  46105%N ;
  59833%N ;
  20930%N ;
  22199%N ;
  24039%N ;
  25088%N ;
  24560%N ;
  32533%N ;
  26928%N ;
  80216%N ;
  40500%N ;
  29243%N ;
  39716%N ;
  38369%N ;
  48254%N ;
  33717%N ;
  37627%N ;
  36808%N ;
  41920%N ;
  38623%N ;
  53391%N ;
  40651%N ;
  43129%N ;
  43760%N ;
  44281%N ;
  44969%N ;
  46759%N ;
  47858%N ;
  46238%N ;
  48599%N ;
  51488%N ;
  53803%N ;
  70160%N ;
  56171%N ;
  69743%N ;
  62960%N ;
  83780%N ;
  73433%N ;
  95311%N ;
  82596%N ;
  85680%N ;
  75431%N ;
  109198%N ;
  115353%N ;
  79274%N ;
  84411%N ;
  121648%N ;
  89250%N ;
  155840%N ;
  90519%N ;
  91207%N ;
  104770%N ;
  158271%N ;
  130649%N ;
  100087%N ;
  105291%N ;
  152756%N ;
  210898%N ;
  277488%N ;
  132703%N ;
  136393%N ;
  152707%N ;
  148864%N ;
  218383%N ;
  154705%N ;
  181726%N ;
  159842%N ;
  169793%N ;
  163685%N ;
  226939%N ;
  173661%N ;
  179769%N ;
  180457%N ;
  230736%N ;
  457257%N ;
  232790%N ;
  314429%N ;
  451173%N ;
  252843%N ;
  205378%N ;
  237994%N ;
  347291%N ;
  269096%N ;
  333164%N ;
  285257%N ;
  467136%N ;
  620966%N ;
  303569%N ;
  314547%N ;
  318390%N ;
  386781%N ;
  455050%N ;
  449553%N ;
  390624%N ;
  360226%N ;
  353430%N ;
  556384%N ;
  385835%N ;
  733126%N ;
  474474%N ;
  618421%N ;
  798464%N ;
  443372%N ;
  458221%N ;
  687547%N ;
  906223%N ;
  554353%N ;
  572665%N ;
  663795%N ;
  1021489%N ;
  618116%N ;
  678616%N ;
  621959%N ;
  1309506%N ;
  671820%N ;
  713656%N ;
  739265%N ;
  744054%N ;
  907783%N ;
  746061%N ;
  827904%N ;
  1865890%N ;
  1478888%N ;
  1706247%N ;
  1579603%N ;
  1145768%N ;
  901593%N ;
  1122016%N ;
  1012574%N ;
  2614030%N ;
  1127018%N ;
  1172469%N ;
  1285754%N ;
  1281911%N ;
  1647048%N ;
  1459717%N ;
  1293779%N ;
  1483319%N ;
  2360704%N ;
  1415874%N ;
  1567169%N ;
  1916523%N ;
  1490115%N ;
  1573965%N ;
  1758635%N ;
  1729497%N ;
  1914167%N ;
  2023609%N ;
  2028611%N ;
  2294485%N ;
  3196078%N ;
  2973434%N ;
  2694187%N ;
  3595780%N ;
  2739638%N ;
  2775869%N ;
  2454380%N ;
  2928959%N ;
  2575690%N ;
  2709653%N ;
  2943036%N ;
  2899193%N ;
  3057284%N ;
  2905989%N ;
  2983043%N ;
  3064080%N ;
  3219612%N ;
  3248750%N ;
  5543235%N ;
  3488132%N ;
  3643664%N ;
  4208652%N ;
  4052220%N ;
  4323096%N ;
  4870175%N ;
  5682674%N ;
  6193046%N ;
  5285343%N ;
  5030070%N ;
  5164033%N ;
  5766937%N ;
  5842229%N ;
  5474883%N ;
  5558733%N ;
  5608846%N ;
  5805182%N ;
  5882236%N ;
  7229085%N ;
  5889032%N ;
  6468362%N ;
  6283692%N ;
  12661408%N ;
  12082078%N ;
  7131796%N ;
  8673734%N ;
  9891326%N ;
  11357079%N ;
  12725954%N ;
  11694214%N ;
  9900245%N ;
  11317112%N ;
  10194103%N ;
  13703804%N ;
  21217357%N ;
  26984294%N ;
  11033616%N ;
  11083729%N ;
  11363915%N ;
  11167579%N ;
  11414028%N ;
  12350598%N ;
  11771268%N ;
  12172724%N ;
  12357394%N ;
  12752054%N ;
  20846458%N ;
  17023122%N ;
  23764626%N ;
  15805530%N ;
  18565060%N ;
  19791571%N ;
  21314273%N ;
  23256453%N ;
  22581607%N ;
  20094348%N ;
  21361682%N ;
  21608131%N ;
  32268864%N ;
  26973109%N ;
  22117345%N ;
  22497757%N ;
  23536639%N ;
  22531494%N ;
  22938847%N ;
  36814693%N ;
  23943992%N ;
  34710115%N ;
  31317114%N ;
  25109448%N ;
  39725163%N ;
  37869580%N ;
  32828652%N ;
  46475486%N ;
  37922875%N ;
  38356631%N ;
  58290223%N ;
  41408621%N ;
  41456030%N ;
  41702479%N ;
  45203796%N ;
  44615102%N ;
  43725476%N ;
  44648839%N ;
  45029251%N ;
  47640942%N ;
  56365291%N ;
  79304138%N ;
  62256657%N ;
  46882839%N ;
  82571714%N ;
  49053440%N ;
  62979028%N ;
  68834924%N ;
  57938100%N ;
  93668542%N ;
  81648351%N ;
  71185283%N ;
  80059110%N ;
  76279506%N ;
  79765252%N ;
  82864651%N ;
  83111100%N ;
  83158509%N ;
  85427955%N ;
  88374315%N ;
  88340578%N ;
  91531678%N ;
  107627867%N ;
  162503466%N ;
  138536163%N ;
  151319606%N ;
  160952489%N ;
  95936279%N ;
  104820939%N ;
  141049200%N ;
  106991540%N ;
  137997210%N ;
  126773024%N ;
  129123383%N ;
  147464789%N ;
  151244393%N ;
  159525861%N ;
  156044758%N ;
  229389778%N ;
  162876352%N ;
  165975751%N ;
  166269609%N ;
  168586464%N ;
  173768533%N ;
  176714893%N ;
  179872256%N ;
  333294394%N ;
  236751250%N ;
  200757218%N ;
  255896407%N ;
  211812479%N ;
  202927819%N ;
  222709303%N ;
  231593963%N ;
  342984502%N ;
  233764564%N ;
  264770234%N ;
  318921110%N ;
  276588172%N ;
  315570619%N ;
  307289151%N ;
  322020509%N ;
  322314367%N ;
  399740315%N ;
  328852103%N ;
  522856758%N ;
  397863572%N ;
  342354997%N ;
  350483426%N ;
  356587149%N ;
  498793366%N ;
  434521782%N ;
  403685037%N ;
  532484579%N ;
  933315148%N ;
  414740298%N ;
  436692383%N ;
  665298869%N ;
  685339499%N ;
  587084601%N ;
  498534798%N ;
  541358406%N ;
  598902539%N ;
  583877323%N ;
  622859770%N ;
  707029466%N ;
  644334876%N ;
  672797793%N ;
  1065039184%N ;
  763373885%N ;
  692838423%N ;
  834555955%N ;
  698942146%N ;
  707070575%N ;
  1197735512%N ;
  1256675116%N ;
  871214165%N ;
  818425335%N ;
  1578243631%N ;
  1433458494%N ;
  851432681%N ;
  935227181%N ;
  1039893204%N ;
  1082412121%N ;
  1097437337%N ;
  1121394568%N ;
  1248387872%N ;
  1228212199%N ;
  1462316031%N ;
  1267194646%N ;
  1317132669%N ;
  1365636216%N ;
  1038347917%N ;
  1391780569%N ;
  1803267089%N ;
  1525495910%N ;
  1753652516%N ;
  1558503256%N ;
  1578284740%N ;
  1689639500%N ;
  1858318539%N ;
  2188346834%N ;
  1669858016%N ;
  2135785254%N ;
  2827952247%N ;
  4406236987%N ;
  1975120385%N ;
  2078241121%N ;
  2120760038%N ;
  2286735789%N ;
  2487030784%N ;
  2515582518%N ;
  2266560116%N ;
  2305542563%N ;
  3387954684%N ;
  6381357372%N ;
  2792000433%N ;
  2841615006%N ;
  2917276479%N ;
  3533623641%N ;
  3312155772%N ;
  3136787996%N ;
  3636744377%N ;
  3248142756%N ;
  3359497516%N ;
  3528176555%N ;
  4773766573%N ;
  4053361506%N ;
  4280662948%N ;
  4095880423%N ;
  6305231163%N ;
  4261856174%N ;
  4199001159%N ;
  4387320154%N ;
  4553295905%N ;
  5357197524%N ;
  5147157569%N ;
  6165419235%N ;
  6607640272%N ;
  6887880856%N ;
  5633615439%N ;
  10024668852%N ;
  8440681660%N ;
  6054064475%N ;
  7920943795%N ;
  7412859022%N ;
  9534477723%N ;
  6996241893%N ;
  6776319311%N ;
  10441384629%N ;
  7581538061%N ;
  8294881582%N ;
  8149241929%N ;
  9637860472%N ;
  8940616059%N ;
  8460857333%N ;
  8752297064%N ;
  11800179176%N ;
  12241255711%N ;
  11522616759%N ;
  12035038425%N ;
  14460300817%N ;
  12409934750%N ;
  15145483822%N ;
  11687679914%N ;
  15936857952%N ;
  12830383786%N ;
  13050306368%N ;
  13466923497%N ;
  15291123475%N ;
  19269217975%N ;
  13772561204%N ;
  18578476531%N ;
  14357857372%N ;
  15730779990%N ;
  15876419643%N ;
  16444123511%N ;
  16901538993%N ;
  17213154397%N ;
  23322795935%N ;
  24989540256%N ;
  34515334483%N ;
  26147980731%N ;
  24572923127%N ;
  23557655184%N ;
  23722718339%N ;
  24097614664%N ;
  35010475849%N ;
  27564099557%N ;
  24737986282%N ;
  25880690154%N ;
  26297307283%N ;
  26517229865%N ;
  27239484701%N ;
  30985715601%N ;
  43510461680%N ;
  28130418576%N ;
  51121754741%N ;
  30088637362%N ;
  55969327516%N ;
  34114693390%N ;
  44008223068%N ;
  42202694653%N ;
  40535950332%N ;
  46880451119%N ;
  47280373523%N ;
  85713156333%N ;
  47655269848%N ;
  48130578311%N ;
  47820333003%N ;
  49603408493%N ;
  48835600946%N ;
  50618676436%N ;
  96483859612%N ;
  51035293565%N ;
  76317388043%N ;
  53536791984%N ;
  54647648441%N ;
  55369903277%N ;
  72291332015%N ;
  64203330752%N ;
  97545015052%N ;
  112333909063%N ;
  81935026393%N ;
  80995144509%N ;
  74650643722%N ;
  82738644985%N ;
  87416401451%N ;
  87816323855%N ;
  103190236280%N ;
  179222504597%N ;
  125152988989%N ;
  95475602851%N ;
  184961416503%N ;
  96655933949%N ;
  110017551718%N ;
  99454277382%N ;
  104572085549%N ;
  191959462463%N ;
  153286476524%N ;
  108184440425%N ;
  135642792950%N ;
  136365047786%N ;
  119573234029%N ;
  136494662767%N ;
  146138357145%N ;
  155645788231%N ;
  194223877751%N ;
  168811468364%N ;
  157389288707%N ;
  162067045173%N ;
  170155046436%N ;
  287435065314%N ;
  183291926706%N ;
  192131536800%N ;
  194929880233%N ;
  196110211331%N ;
  204026362931%N ;
  201228019498%N ;
  324457256595%N ;
  207638717807%N ;
  255100065613%N ;
  272007840736%N ;
  227757674454%N ;
  243827233375%N ;
  305797839386%N ;
  255216026979%N ;
  326200757071%N ;
  256067896796%N ;
  292140450998%N ;
  360943005164%N ;
  319456333880%N ;
  338966514800%N ;
  358617308205%N ;
  327544335143%N ;
  425371073415%N ;
  451210276944%N ;
  375423463506%N ;
  559845327703%N ;
  387061417033%N ;
  560897904999%N ;
  499895130171%N ;
  405254382429%N ;
  408866737305%N ;
  527107906349%N ;
  462854744786%N ;
  471584907829%N ;
  678073642085%N ;
  482973701433%N ;
  563283567255%N ;
  1011055604647%N ;
  511283923775%N ;
  810551422629%N ;
  767351820571%N ;
  611596784878%N ;
  792315799462%N ;
  702967798649%N ;
  666510849943%N ;
  686161643348%N ;
  946906744736%N ;
  762484880539%N ;
  875318593677%N ;
  780677845935%N ;
  795928154338%N ;
  814121119734%N ;
  1071765232372%N ;
  868109127215%N ;
  871721482091%N ;
  1470319619220%N ;
  934439652615%N ;
  1406024560444%N ;
  1238936728400%N ;
  1197445567123%N ;
  1046257268688%N ;
  1174880352133%N ;
  1495283598111%N ;
  1635460947786%N ;
  1739830609306%N ;
  1667634393139%N ;
  1278107634821%N ;
  1352672493291%N ;
  2250997465155%N ;
  1428995730482%N ;
  1808742149227%N ;
  1630594007754%N ;
  1543162726474%N ;
  1939874359587%N ;
  1576606000273%N ;
  1610049274072%N ;
  1682230246949%N ;
  1917978750779%N ;
  3304025747338%N ;
  1806161134706%N ;
  2212547287436%N ;
  2109320004748%N ;
  2541540866799%N ;
  2221137620821%N ;
  2626441297605%N ;
  2398929761979%N ;
  3794160191629%N ;
  3084268769527%N ;
  2854713635094%N ;
  2630780128112%N ;
  3614903283933%N ;
  2707103365303%N ;
  2781668223773%N ;
  3111225977431%N ;
  3368870090069%N ;
  3119768726747%N ;
  4880631747611%N ;
  3549923633659%N ;
  6575828415402%N ;
  3186655274345%N ;
  3292279521021%N ;
  4459519617578%N ;
  5910410956868%N ;
  4890988228521%N ;
  3915481139454%N ;
  4321867292184%N ;
  4330457625569%N ;
  6230994704178%N ;
  4620067382800%N ;
  5029709890091%N ;
  5892894201204%N ;
  5974482361841%N ;
  10851062086978%N ;
  5337883493415%N ;
  5412448351885%N ;
  5488771589076%N ;
  7912346903821%N ;
  5901436950520%N ;
  6297881251776%N ;
  10594549744641%N ;
  6412048247768%N ;
  7751799138599%N ;
  10232278249052%N ;
  6478934795366%N ;
  7102136413799%N ;
  10223351826773%N ;
  9889963501295%N ;
  8237348431638%N ;
  10394415934820%N ;
  8941934674984%N ;
  8652324917753%N ;
  8950525008369%N ;
  18875676744526%N ;
  9649777272891%N ;
  16263510438863%N ;
  15138548861967%N ;
  16404124056352%N ;
  10750331845300%N ;
  11313885302405%N ;
  12776816047142%N ;
  11390208539596%N ;
  12199318202296%N ;
  12313485198288%N ;
  14535229683414%N ;
  12890983043134%N ;
  13514184661567%N ;
  13581071209165%N ;
  15420869470350%N ;
  15339484845437%N ;
  25354649064721%N ;
  16889673349391%N ;
  17179283106622%N ;
  20436666633934%N ;
  28049414344981%N ;
  27794332595948%N ;
  17602849926122%N ;
  19700856853669%N ;
  20400109118191%N ;
  22540760316025%N ;
  23641314888434%N ;
  33950851295501%N ;
  22064217147705%N ;
  28920556054602%N ;
  47895409380746%N ;
  33213482681076%N ;
  24512803400584%N ;
  29378601308918%N ;
  25204468241422%N ;
  26405167704701%N ;
  33291092161325%N ;
  27095255870732%N ;
  42957498990843%N ;
  51759816769422%N ;
  59618650385777%N ;
  34068956456013%N ;
  34492523275513%N ;
  38002959044313%N ;
  42241617169694%N ;
  37303706779791%N ;
  39667067073827%N ;
  88997251694695%N ;
  40100965971860%N ;
  42464326265896%N ;
  44604977463730%N ;
  52561870943036%N ;
  46577020548289%N ;
  49159473018437%N ;
  79868112709614%N ;
  86023818090478%N ;
  49717271642006%N ;
  135574272242984%N ;
  51609635946123%N ;
  60386348032057%N
].