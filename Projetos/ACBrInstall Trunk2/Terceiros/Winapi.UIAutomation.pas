{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2020-2025 Embarcadero Technologies, Inc. }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UIAutomation;

{$HPPEMIT NOUSINGNAMESPACE}
{$HPPEMIT '#include <UIAutomation.h>'}
{$HPPEMIT '#include <richedit.h>'}
{$HPPEMIT '#include <TextServ.h>'}
{$HPPEMIT '#pragma comment(lib, "UIAutomationCore")'}


{$WARN SYMBOL_DEPRECATED OFF}

interface

{$MINENUMSIZE 4}

uses
  Winapi.Windows, System.Types, System.Classes, System.Variants, Winapi.ActiveX;

const
  CLSID_CUIAutomation: TGuid = '{FF48DBA4-60EF-4201-AA87-54103EEF594E}';
  {EXTERNALSYM CLSID_CUIAutomation}
  CLSID_CUIAutomationRegistrar: TGuid = '{6E29FABF-9977-42D1-8D0E-CA7E61AD87E6}';
  {EXTERNALSYM CLSID_CUIAutomationRegistrar}
  CLSID_CAccPropServices: TGuid = '{B5F8350B-0548-48B1-A6EE-88BD00B4A5E7}';
  {EXTERNALSYM CLSID_CAccPropServices}
  CLSID_CUIAutomation8: TGuid = '{E22AD333-B25F-460C-83D0-0581107395C9}';
  {EXTERNALSYM CLSID_CUIAutomation8}

  IID_IRawElementProviderSimple: TGUID = '{D6DD68D1-86FD-4332-8666-9ABEDEA2D24C}';
  {$EXTERNALSYM IID_IRawElementProviderSimple}
  IID_IRawElementProviderSimple2: TGUID = '{A0A839A9-8DA1-4A82-806A-8E0D44E79F56}';
  {$EXTERNALSYM IID_IRawElementProviderSimple2}
  IID_IRawElementProviderSimple3: TGUID = '{FCF5D820-D7EC-4613-BDF6-42A84CE7DAAF}';
  {$EXTERNALSYM IID_IRawElementProviderSimple3}
  IID_IRawElementProviderFragmentRoot: TGUID = '{620CE2A5-AB8F-40A9-86CB-DE3C75599B58}';
  {$EXTERNALSYM IID_IRawElementProviderFragmentRoot}
  IID_IRawElementProviderFragment: TGUID = '{F7063DA8-8359-439C-9297-BBC5299A7D87}';
  {$EXTERNALSYM IID_IRawElementProviderFragment}
  IID_IRawElementProviderAdviseEvents: TGUID = '{A407B27B-0F6D-4427-9292-473C7BF93258}';
  {$EXTERNALSYM IID_IRawElementProviderAdviseEvents}
  IID_IRawElementProviderHwndOverride: TGUID = '{1D5DF27C-8947-4425-B8D9-79787BB460B8}';
  {$EXTERNALSYM IID_IRawElementProviderHwndOverride}
  IID_IProxyProviderWinEventSink: TGUID = '{4FD82B78-A43E-46AC-9803-0A6969C7C183}';
  {$EXTERNALSYM IID_IProxyProviderWinEventSink}
  IID_IProxyProviderWinEventHandler: TGUID = '{89592AD4-F4E0-43D5-A3B6-BAD7E111B435}';
  {$EXTERNALSYM IID_IProxyProviderWinEventHandler}
  IID_IRawElementProviderWindowlessSite: TGUID = '{0A2A93CC-BFAD-42AC-9B2E-0991FB0D3EA0}';
  {$EXTERNALSYM IID_IRawElementProviderWindowlessSite}
  IID_IAccessibleHostingElementProviders: TGUID = '{33AC331B-943E-4020-B295-DB37784974A3}';
  {$EXTERNALSYM IID_IAccessibleHostingElementProviders}
  IID_IRawElementProviderHostingAccessibles: TGUID = '{24BE0B07-D37D-487A-98CF-A13ED465E9B3}';
  {$EXTERNALSYM IID_IRawElementProviderHostingAccessibles}
  IID_IDockProvider: TGUID = '{159BC72C-4AD3-485E-9637-D7052EDF0146}';
  {$EXTERNALSYM IID_IDockProvider}
  IID_IExpandCollapseProvider: TGUID = '{D847D3A5-CAB0-4A98-8C32-ECB45C59AD24}';
  {$EXTERNALSYM IID_IExpandCollapseProvider}
  IID_IGridProvider: TGUID = '{B17D6187-0907-464B-A168-0EF17A1572B1}';
  {$EXTERNALSYM IID_IGridProvider}
  IID_IGridItemProvider: TGUID = '{D02541F1-FB81-4D64-AE32-F520F8A6DBD1}';
  {$EXTERNALSYM IID_IGridItemProvider}
  IID_IInvokeProvider: TGUID = '{54FCB24B-E18E-47A2-B4D3-ECCBE77599A2}';
  {$EXTERNALSYM IID_IInvokeProvider}
  IID_IMultipleViewProvider: TGUID = '{6278CAB1-B556-4A1A-B4E0-418ACC523201}';
  {$EXTERNALSYM IID_IMultipleViewProvider}
  IID_IRangeValueProvider: TGUID = '{36DC7AEF-33E6-4691-AFE1-2BE7274B3D33}';
  {$EXTERNALSYM IID_IRangeValueProvider}
  IID_IScrollItemProvider: TGUID = '{2360C714-4BF1-4B26-BA65-9B21316127EB}';
  {$EXTERNALSYM IID_IScrollItemProvider}
  IID_ISelectionProvider: TGUID = '{FB8B03AF-3BDF-48D4-BD36-1A65793BE168}';
  {$EXTERNALSYM IID_ISelectionProvider}
  IID_ISelectionProvider2: TGUID = '{14F68475-EE1C-44F6-A869-D239381F0FE7}';
  {$EXTERNALSYM IID_ISelectionProvider2}
  IID_IScrollProvider: TGUID = '{B38B8077-1FC3-42A5-8CAE-D40C2215055A}';
  {$EXTERNALSYM IID_IScrollProvider}
  IID_ISelectionItemProvider: TGUID = '{2ACAD808-B2D4-452D-A407-91FF1AD167B2}';
  {$EXTERNALSYM IID_ISelectionItemProvider}
  IID_ISynchronizedInputProvider: TGUID = '{29DB1A06-02CE-4CF7-9B42-565D4FAB20EE}';
  {$EXTERNALSYM IID_ISynchronizedInputProvider}
  IID_ITableProvider: TGUID = '{9C860395-97B3-490A-B52A-858CC22AF166}';
  {$EXTERNALSYM IID_ITableProvider}
  IID_ITableItemProvider: TGUID = '{B9734FA6-771F-4D78-9C90-2517999349CD}';
  {$EXTERNALSYM IID_ITableItemProvider}
  IID_IToggleProvider: TGUID = '{56D00BD0-C4F4-433C-A836-1A52A57E0892}';
  {$EXTERNALSYM IID_IToggleProvider}
  IID_ITransformProvider: TGUID = '{6829DDC4-4F91-4FFA-B86F-BD3E2987CB4C}';
  {$EXTERNALSYM IID_ITransformProvider}
  IID_IValueProvider: TGUID = '{C7935180-6FB3-4201-B174-7DF73ADBF64A}';
  {$EXTERNALSYM IID_IValueProvider}
  IID_IWindowProvider: TGUID = '{987DF77B-DB06-4D77-8F8A-86A9C3BB90B9}';
  {$EXTERNALSYM IID_IWindowProvider}
  IID_IItemContainerProvider: TGUID = '{E747770B-39CE-4382-AB30-D8FB3F336F24}';
  {$EXTERNALSYM IID_IItemContainerProvider}
  IID_IVirtualizedItemProvider: TGUID = '{CB98B665-2D35-4FAC-AD35-F3C60D0C0B8B}';
  {$EXTERNALSYM IID_IVirtualizedItemProvider}
  IID_IObjectModelProvider: TGUID = '{3AD86EBD-F5EF-483D-BB18-B1042A475D64}';
  {$EXTERNALSYM IID_IObjectModelProvider}
  IID_IAnnotationProvider: TGUID = '{F95C7E80-BD63-4601-9782-445EBFF011FC}';
  {$EXTERNALSYM IID_IAnnotationProvider}
  IID_IStylesProvider: TGUID = '{19B6B649-F5D7-4A6D-BDCB-129252BE588A}';
  {$EXTERNALSYM IID_IStylesProvider}
  IID_ISpreadsheetProvider: TGUID = '{6F6B5D35-5525-4F80-B758-85473832FFC7}';
  {$EXTERNALSYM IID_ISpreadsheetProvider}
  IID_ISpreadsheetItemProvider: TGUID = '{EAED4660-7B3D-4879-A2E6-365CE603F3D0}';
  {$EXTERNALSYM IID_ISpreadsheetItemProvider}
  IID_ITransformProvider2: TGUID = '{4758742F-7AC2-460C-BC48-09FC09308A93}';
  {$EXTERNALSYM IID_ITransformProvider2}
  IID_IDragProvider: TGUID = '{6AA7BBBB-7FF9-497D-904F-D20B897929D8}';
  {$EXTERNALSYM IID_IDragProvider}
  IID_IDropTargetProvider: TGUID = '{BAE82BFD-358A-481C-85A0-D8B4D90A5D61}';
  {$EXTERNALSYM IID_IDropTargetProvider}
  IID_ITextRangeProvider: TGUID = '{5347AD7B-C355-46F8-AFF5-909033582F63}';
  {$EXTERNALSYM IID_ITextRangeProvider}
  IID_ITextProvider: TGUID = '{3589C92C-63F3-4367-99BB-ADA653B77CF2}';
  {$EXTERNALSYM IID_ITextProvider}
  IID_ITextProvider2: TGUID = '{0DC5E6ED-3E16-4BF1-8F9A-A979878BC195}';
  {$EXTERNALSYM IID_ITextProvider2}
  IID_ITextEditProvider: TGUID = '{EA3605B4-3A05-400E-B5F9-4E91B40F6176}';
  {$EXTERNALSYM IID_ITextEditProvider}
  IID_ITextRangeProvider2: TGUID = '{9BBCE42C-1921-4F18-89CA-DBA1910A0386}';
  {$EXTERNALSYM IID_ITextRangeProvider2}
  IID_ITextChildProvider: TGUID = '{4C2DE2B9-C88F-4F88-A111-F1D336B7D1A9}';
  {$EXTERNALSYM IID_ITextChildProvider}
  IID_ICustomNavigationProvider: TGUID = '{2062A28A-8C07-4B94-8E12-7037C622AEB8}';
  {$EXTERNALSYM IID_ICustomNavigationProvider}
  IID_IUIAutomationPatternInstance: TGUID = '{C03A7FE4-9431-409F-BED8-AE7C2299BC8D}';
  {$EXTERNALSYM IID_IUIAutomationPatternInstance}
  IID_IUIAutomationPatternHandler: TGUID = '{D97022F3-A947-465E-8B2A-AC4315FA54E8}';
  {$EXTERNALSYM IID_IUIAutomationPatternHandler}
  IID_IUIAutomationRegistrar: TGUID = '{8609C4EC-4A1A-4D88-A357-5A66E060E1CF}';
  {$EXTERNALSYM IID_IUIAutomationRegistrar}

type
  PHWND = ^HWND;

  PFlowDirections = ^FlowDirections;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-flowdirections</summary>
  FlowDirections = Integer;
  {$EXTERNALSYM FlowDirections}
const
  // Constants for enum FlowDirections
  FlowDirections_Default = $0 { 0 };
  {$EXTERNALSYM FlowDirections_Default}
  FlowDirections_RightToLeft = $1 { 1 };
  {$EXTERNALSYM FlowDirections_RightToLeft}
  FlowDirections_BottomToTop = $2 { 2 };
  {$EXTERNALSYM FlowDirections_BottomToTop}
  FlowDirections_Vertical = $4 { 4 };
  {$EXTERNALSYM FlowDirections_Vertical}

type
  PLiveSetting = ^LiveSetting;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-livesetting</summary>
  LiveSetting = (
    Off,
    Polite,
    Assertive
  );
  {$EXTERNALSYM LiveSetting}

type
  PSupportedTextSelection = ^SupportedTextSelection;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-supportedtextselection</summary>
  SupportedTextSelection = (
    SupportedTextSelection_None,
    SupportedTextSelection_Single,
    SupportedTextSelection_Multiple
  );
  {$EXTERNALSYM SupportedTextSelection}

type
  PTreeTraversalOptions = ^TreeTraversalOptions;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-treetraversaloptions</summary>
  TreeTraversalOptions = (
    TreeTraversalOptions_Default,
    TreeTraversalOptions_PostOrder,
    TreeTraversalOptions_LastToFirstOrder
  );
  {$EXTERNALSYM TreeTraversalOptions}

type
  PNotificationProcessing = ^NotificationProcessing;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-notificationprocessing</summary>
  NotificationProcessing = (
    NotificationProcessing_ImportantAll,
    NotificationProcessing_ImportantMostRecent,
    NotificationProcessing_All,
    NotificationProcessing_MostRecent,
    NotificationProcessing_CurrentThenMostRecent
  );
  {$EXTERNALSYM NotificationProcessing}

type
  PAsyncContentLoadedState = ^AsyncContentLoadedState;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-asynccontentloadedstate</summary>
  AsyncContentLoadedState = (
    AsyncContentLoadedState_Beginning,
    AsyncContentLoadedState_Progress,
    AsyncContentLoadedState_Completed
  );
  {$EXTERNALSYM AsyncContentLoadedState}

type
  PConnectionRecoveryBehaviorOptions = ^ConnectionRecoveryBehaviorOptions;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/ne-uiautomationclient-connectionrecoverybehavioroptions</summary>
  ConnectionRecoveryBehaviorOptions = (
    ConnectionRecoveryBehaviorOptions_Disabled,
    ConnectionRecoveryBehaviorOptions_Enabled
  );
  {$EXTERNALSYM ConnectionRecoveryBehaviorOptions}

type
  PAutomationIdentifierType = ^AutomationIdentifierType;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-automationidentifiertype</summary>
  AutomationIdentifierType = (
    AutomationIdentifierType_Property,
    AutomationIdentifierType_Pattern,
    AutomationIdentifierType_Event,
    AutomationIdentifierType_ControlType,
    AutomationIdentifierType_TextAttribute,
    AutomationIdentifierType_LandmarkType,
    AutomationIdentifierType_Annotation,
    AutomationIdentifierType_Changes,
    AutomationIdentifierType_Style
  );
  {$EXTERNALSYM AutomationIdentifierType}

type
  PCapStyle = ^CapStyle;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-capstyle</summary>
  CapStyle = Integer;
  {$EXTERNALSYM CapStyle}
const
  // Constants for enum CapStyle
  CapStyle_Other = $FFFFFFFF { -1 };
  {$EXTERNALSYM CapStyle_Other}
  CapStyle_None = $0 { 0 };
  {$EXTERNALSYM CapStyle_None}
  CapStyle_SmallCap = $1 { 1 };
  {$EXTERNALSYM CapStyle_SmallCap}
  CapStyle_AllCap = $2 { 2 };
  {$EXTERNALSYM CapStyle_AllCap}
  CapStyle_AllPetiteCaps = $3 { 3 };
  {$EXTERNALSYM CapStyle_AllPetiteCaps}
  CapStyle_PetiteCaps = $4 { 4 };
  {$EXTERNALSYM CapStyle_PetiteCaps}
  CapStyle_Unicase = $5 { 5 };
  {$EXTERNALSYM CapStyle_Unicase}
  CapStyle_Titling = $6 { 6 };
  {$EXTERNALSYM CapStyle_Titling}

type
  PHIGHCONTRASTW_FLAGS = ^HIGHCONTRASTW_FLAGS;
  ///<remarks>This enumerated type is made up of bitwise flag values</remarks>
  HIGHCONTRASTW_FLAGS = Cardinal;
  {$EXTERNALSYM HIGHCONTRASTW_FLAGS}
const
  // Constants for enum HIGHCONTRASTW_FLAGS
  HCF_HIGHCONTRASTON = $1 { 1 };
  {$EXTERNALSYM HCF_HIGHCONTRASTON}
  HCF_AVAILABLE = $2 { 2 };
  {$EXTERNALSYM HCF_AVAILABLE}
  HCF_HOTKEYACTIVE = $4 { 4 };
  {$EXTERNALSYM HCF_HOTKEYACTIVE}
  HCF_CONFIRMHOTKEY = $8 { 8 };
  {$EXTERNALSYM HCF_CONFIRMHOTKEY}
  HCF_HOTKEYSOUND = $10 { 16 };
  {$EXTERNALSYM HCF_HOTKEYSOUND}
  HCF_INDICATOR = $20 { 32 };
  {$EXTERNALSYM HCF_INDICATOR}
  HCF_HOTKEYAVAILABLE = $40 { 64 };
  {$EXTERNALSYM HCF_HOTKEYAVAILABLE}
  HCF_OPTION_NOTHEMECHANGE = $1000 { 4096 };
  {$EXTERNALSYM HCF_OPTION_NOTHEMECHANGE}

type
  PUIA_TEXTATTRIBUTE_ID = ^UIA_TEXTATTRIBUTE_ID;
  UIA_TEXTATTRIBUTE_ID = Cardinal;
  {$EXTERNALSYM UIA_TEXTATTRIBUTE_ID}
const
  // Constants for enum UIA_TEXTATTRIBUTE_ID
  UIA_AnimationStyleAttributeId = $9C40 { 40000 };
  {$EXTERNALSYM UIA_AnimationStyleAttributeId}
  UIA_BackgroundColorAttributeId = $9C41 { 40001 };
  {$EXTERNALSYM UIA_BackgroundColorAttributeId}
  UIA_BulletStyleAttributeId = $9C42 { 40002 };
  {$EXTERNALSYM UIA_BulletStyleAttributeId}
  UIA_CapStyleAttributeId = $9C43 { 40003 };
  {$EXTERNALSYM UIA_CapStyleAttributeId}
  UIA_CultureAttributeId = $9C44 { 40004 };
  {$EXTERNALSYM UIA_CultureAttributeId}
  UIA_FontNameAttributeId = $9C45 { 40005 };
  {$EXTERNALSYM UIA_FontNameAttributeId}
  UIA_FontSizeAttributeId = $9C46 { 40006 };
  {$EXTERNALSYM UIA_FontSizeAttributeId}
  UIA_FontWeightAttributeId = $9C47 { 40007 };
  {$EXTERNALSYM UIA_FontWeightAttributeId}
  UIA_ForegroundColorAttributeId = $9C48 { 40008 };
  {$EXTERNALSYM UIA_ForegroundColorAttributeId}
  UIA_HorizontalTextAlignmentAttributeId = $9C49 { 40009 };
  {$EXTERNALSYM UIA_HorizontalTextAlignmentAttributeId}
  UIA_IndentationFirstLineAttributeId = $9C4A { 40010 };
  {$EXTERNALSYM UIA_IndentationFirstLineAttributeId}
  UIA_IndentationLeadingAttributeId = $9C4B { 40011 };
  {$EXTERNALSYM UIA_IndentationLeadingAttributeId}
  UIA_IndentationTrailingAttributeId = $9C4C { 40012 };
  {$EXTERNALSYM UIA_IndentationTrailingAttributeId}
  UIA_IsHiddenAttributeId = $9C4D { 40013 };
  {$EXTERNALSYM UIA_IsHiddenAttributeId}
  UIA_IsItalicAttributeId = $9C4E { 40014 };
  {$EXTERNALSYM UIA_IsItalicAttributeId}
  UIA_IsReadOnlyAttributeId = $9C4F { 40015 };
  {$EXTERNALSYM UIA_IsReadOnlyAttributeId}
  UIA_IsSubscriptAttributeId = $9C50 { 40016 };
  {$EXTERNALSYM UIA_IsSubscriptAttributeId}
  UIA_IsSuperscriptAttributeId = $9C51 { 40017 };
  {$EXTERNALSYM UIA_IsSuperscriptAttributeId}
  UIA_MarginBottomAttributeId = $9C52 { 40018 };
  {$EXTERNALSYM UIA_MarginBottomAttributeId}
  UIA_MarginLeadingAttributeId = $9C53 { 40019 };
  {$EXTERNALSYM UIA_MarginLeadingAttributeId}
  UIA_MarginTopAttributeId = $9C54 { 40020 };
  {$EXTERNALSYM UIA_MarginTopAttributeId}
  UIA_MarginTrailingAttributeId = $9C55 { 40021 };
  {$EXTERNALSYM UIA_MarginTrailingAttributeId}
  UIA_OutlineStylesAttributeId = $9C56 { 40022 };
  {$EXTERNALSYM UIA_OutlineStylesAttributeId}
  UIA_OverlineColorAttributeId = $9C57 { 40023 };
  {$EXTERNALSYM UIA_OverlineColorAttributeId}
  UIA_OverlineStyleAttributeId = $9C58 { 40024 };
  {$EXTERNALSYM UIA_OverlineStyleAttributeId}
  UIA_StrikethroughColorAttributeId = $9C59 { 40025 };
  {$EXTERNALSYM UIA_StrikethroughColorAttributeId}
  UIA_StrikethroughStyleAttributeId = $9C5A { 40026 };
  {$EXTERNALSYM UIA_StrikethroughStyleAttributeId}
  UIA_TabsAttributeId = $9C5B { 40027 };
  {$EXTERNALSYM UIA_TabsAttributeId}
  UIA_TextFlowDirectionsAttributeId = $9C5C { 40028 };
  {$EXTERNALSYM UIA_TextFlowDirectionsAttributeId}
  UIA_UnderlineColorAttributeId = $9C5D { 40029 };
  {$EXTERNALSYM UIA_UnderlineColorAttributeId}
  UIA_UnderlineStyleAttributeId = $9C5E { 40030 };
  {$EXTERNALSYM UIA_UnderlineStyleAttributeId}
  UIA_AnnotationTypesAttributeId = $9C5F { 40031 };
  {$EXTERNALSYM UIA_AnnotationTypesAttributeId}
  UIA_AnnotationObjectsAttributeId = $9C60 { 40032 };
  {$EXTERNALSYM UIA_AnnotationObjectsAttributeId}
  UIA_StyleNameAttributeId = $9C61 { 40033 };
  {$EXTERNALSYM UIA_StyleNameAttributeId}
  UIA_StyleIdAttributeId = $9C62 { 40034 };
  {$EXTERNALSYM UIA_StyleIdAttributeId}
  UIA_LinkAttributeId = $9C63 { 40035 };
  {$EXTERNALSYM UIA_LinkAttributeId}
  UIA_IsActiveAttributeId = $9C64 { 40036 };
  {$EXTERNALSYM UIA_IsActiveAttributeId}
  UIA_SelectionActiveEndAttributeId = $9C65 { 40037 };
  {$EXTERNALSYM UIA_SelectionActiveEndAttributeId}
  UIA_CaretPositionAttributeId = $9C66 { 40038 };
  {$EXTERNALSYM UIA_CaretPositionAttributeId}
  UIA_CaretBidiModeAttributeId = $9C67 { 40039 };
  {$EXTERNALSYM UIA_CaretBidiModeAttributeId}
  UIA_LineSpacingAttributeId = $9C68 { 40040 };
  {$EXTERNALSYM UIA_LineSpacingAttributeId}
  UIA_BeforeParagraphSpacingAttributeId = $9C69 { 40041 };
  {$EXTERNALSYM UIA_BeforeParagraphSpacingAttributeId}
  UIA_AfterParagraphSpacingAttributeId = $9C6A { 40042 };
  {$EXTERNALSYM UIA_AfterParagraphSpacingAttributeId}
  UIA_SayAsInterpretAsAttributeId = $9C6B { 40043 };
  {$EXTERNALSYM UIA_SayAsInterpretAsAttributeId}

type
  PAutomationElementMode = ^AutomationElementMode;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-automationelementmode</summary>
  AutomationElementMode = (
    AutomationElementMode_None,
    AutomationElementMode_Full
  );
  {$EXTERNALSYM AutomationElementMode}

type
  PCaretPosition = ^CaretPosition;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-caretposition</summary>
  CaretPosition = (
    CaretPosition_Unknown,
    CaretPosition_EndOfLine,
    CaretPosition_BeginningOfLine
  );
  {$EXTERNALSYM CaretPosition}

type
  PEventArgsType = ^EventArgsType;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-eventargstype</summary>
  EventArgsType = (
    EventArgsType_Simple,
    EventArgsType_PropertyChanged,
    EventArgsType_StructureChanged,
    EventArgsType_AsyncContentLoaded,
    EventArgsType_WindowClosed,
    EventArgsType_TextEditTextChanged,
    EventArgsType_Changes,
    EventArgsType_Notification,
    EventArgsType_ActiveTextPositionChanged,
    EventArgsType_StructuredMarkup
  );
  {$EXTERNALSYM EventArgsType}

type
  PSOUNDSENTRY_TEXT_EFFECT = ^SOUNDSENTRY_TEXT_EFFECT;
  SOUNDSENTRY_TEXT_EFFECT = Cardinal;
  {$EXTERNALSYM SOUNDSENTRY_TEXT_EFFECT}
const
  // Constants for enum SOUNDSENTRY_TEXT_EFFECT
  SSTF_BORDER = $2 { 2 };
  {$EXTERNALSYM SSTF_BORDER}
  SSTF_CHARS = $1 { 1 };
  {$EXTERNALSYM SSTF_CHARS}
  SSTF_DISPLAY = $3 { 3 };
  {$EXTERNALSYM SSTF_DISPLAY}
  SSTF_NONE = $0 { 0 };
  {$EXTERNALSYM SSTF_NONE}

type
  PSERIALKEYS_FLAGS = ^SERIALKEYS_FLAGS;
  ///<remarks>This enumerated type is made up of bitwise flag values</remarks>
  SERIALKEYS_FLAGS = Cardinal;
  {$EXTERNALSYM SERIALKEYS_FLAGS}
const
  // Constants for enum SERIALKEYS_FLAGS
  SERKF_AVAILABLE = $2 { 2 };
  {$EXTERNALSYM SERKF_AVAILABLE}
  SERKF_INDICATOR = $4 { 4 };
  {$EXTERNALSYM SERKF_INDICATOR}
  SERKF_SERIALKEYSON = $1 { 1 };
  {$EXTERNALSYM SERKF_SERIALKEYSON}

type
  PNotificationKind = ^NotificationKind;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-notificationkind</summary>
  NotificationKind = (
    NotificationKind_ItemAdded,
    NotificationKind_ItemRemoved,
    NotificationKind_ActionCompleted,
    NotificationKind_ActionAborted,
    NotificationKind_Other
  );
  {$EXTERNALSYM NotificationKind}

type
  PSOUND_SENTRY_GRAPHICS_EFFECT = ^SOUND_SENTRY_GRAPHICS_EFFECT;
  SOUND_SENTRY_GRAPHICS_EFFECT = Cardinal;
  {$EXTERNALSYM SOUND_SENTRY_GRAPHICS_EFFECT}
const
  // Constants for enum SOUND_SENTRY_GRAPHICS_EFFECT
  SSGF_DISPLAY = $3 { 3 };
  {$EXTERNALSYM SSGF_DISPLAY}
  SSGF_NONE = $0 { 0 };
  {$EXTERNALSYM SSGF_NONE}

type
  PAnimationStyle = ^AnimationStyle;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-animationstyle</summary>
  AnimationStyle = Integer;
  {$EXTERNALSYM AnimationStyle}
const
  // Constants for enum AnimationStyle
  AnimationStyle_Other = $FFFFFFFF { -1 };
  {$EXTERNALSYM AnimationStyle_Other}
  AnimationStyle_None = $0 { 0 };
  {$EXTERNALSYM AnimationStyle_None}
  AnimationStyle_LasVegasLights = $1 { 1 };
  {$EXTERNALSYM AnimationStyle_LasVegasLights}
  AnimationStyle_BlinkingBackground = $2 { 2 };
  {$EXTERNALSYM AnimationStyle_BlinkingBackground}
  AnimationStyle_SparkleText = $3 { 3 };
  {$EXTERNALSYM AnimationStyle_SparkleText}
  AnimationStyle_MarchingBlackAnts = $4 { 4 };
  {$EXTERNALSYM AnimationStyle_MarchingBlackAnts}
  AnimationStyle_MarchingRedAnts = $5 { 5 };
  {$EXTERNALSYM AnimationStyle_MarchingRedAnts}
  AnimationStyle_Shimmer = $6 { 6 };
  {$EXTERNALSYM AnimationStyle_Shimmer}

type
  PNavigateDirection = ^NavigateDirection;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-navigatedirection</summary>
  NavigateDirection = (
    NavigateDirection_Parent,
    NavigateDirection_NextSibling,
    NavigateDirection_PreviousSibling,
    NavigateDirection_FirstChild,
    NavigateDirection_LastChild
  );
  {$EXTERNALSYM NavigateDirection}

type
  PNormalizeState = ^NormalizeState;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-normalizestate</summary>
  NormalizeState = (
    NormalizeState_None,
    NormalizeState_View,
    NormalizeState_Custom
  );
  {$EXTERNALSYM NormalizeState}

type
  PUIA_METADATA_ID = ^UIA_METADATA_ID;
  UIA_METADATA_ID = Cardinal;
  {$EXTERNALSYM UIA_METADATA_ID}
const
  // Constants for enum UIA_METADATA_ID
  UIA_SayAsInterpretAsMetadataId = $186A0 { 100000 };
  {$EXTERNALSYM UIA_SayAsInterpretAsMetadataId}

type
  PZoomUnit = ^ZoomUnit;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-zoomunit</summary>
  ZoomUnit = (
    ZoomUnit_NoAmount,
    ZoomUnit_LargeDecrement,
    ZoomUnit_SmallDecrement,
    ZoomUnit_LargeIncrement,
    ZoomUnit_SmallIncrement
  );
  {$EXTERNALSYM ZoomUnit}

type
  PCaretBidiMode = ^CaretBidiMode;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-caretbidimode</summary>
  CaretBidiMode = (
    CaretBidiMode_LTR,
    CaretBidiMode_RTL
  );
  {$EXTERNALSYM CaretBidiMode}

type
  PTreeScope = ^TreeScope;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-treescope</summary>
  TreeScope = Integer;
  {$EXTERNALSYM TreeScope}
const
  // Constants for enum TreeScope
  TreeScope_None = $0 { 0 };
  {$EXTERNALSYM TreeScope_None}
  TreeScope_Element = $1 { 1 };
  {$EXTERNALSYM TreeScope_Element}
  TreeScope_Children = $2 { 2 };
  {$EXTERNALSYM TreeScope_Children}
  TreeScope_Descendants = $4 { 4 };
  {$EXTERNALSYM TreeScope_Descendants}
  TreeScope_Subtree = $7 { 7 };
  {$EXTERNALSYM TreeScope_Subtree}
  TreeScope_Parent = $8 { 8 };
  {$EXTERNALSYM TreeScope_Parent}
  TreeScope_Ancestors = $10 { 16 };
  {$EXTERNALSYM TreeScope_Ancestors}

type
  PCoalesceEventsOptions = ^CoalesceEventsOptions;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/ne-uiautomationclient-coalesceeventsoptions</summary>
  CoalesceEventsOptions = (
    CoalesceEventsOptions_Disabled,
    CoalesceEventsOptions_Enabled
  );
  {$EXTERNALSYM CoalesceEventsOptions}

type
  PACC_UTILITY_STATE_FLAGS = ^ACC_UTILITY_STATE_FLAGS;
  ///<remarks>This enumerated type is made up of bitwise flag values</remarks>
  ACC_UTILITY_STATE_FLAGS = Cardinal;
  {$EXTERNALSYM ACC_UTILITY_STATE_FLAGS}
const
  // Constants for enum ACC_UTILITY_STATE_FLAGS
  ANRUS_ON_SCREEN_KEYBOARD_ACTIVE = $1 { 1 };
  {$EXTERNALSYM ANRUS_ON_SCREEN_KEYBOARD_ACTIVE}
  ANRUS_TOUCH_MODIFICATION_ACTIVE = $2 { 2 };
  {$EXTERNALSYM ANRUS_TOUCH_MODIFICATION_ACTIVE}
  ANRUS_PRIORITY_AUDIO_ACTIVE = $4 { 4 };
  {$EXTERNALSYM ANRUS_PRIORITY_AUDIO_ACTIVE}
  ANRUS_PRIORITY_AUDIO_ACTIVE_NODUCK = $8 { 8 };
  {$EXTERNALSYM ANRUS_PRIORITY_AUDIO_ACTIVE_NODUCK}

type
  PWindowInteractionState = ^WindowInteractionState;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-windowinteractionstate</summary>
  WindowInteractionState = (
    WindowInteractionState_Running,
    WindowInteractionState_Closing,
    WindowInteractionState_ReadyForUserInteraction,
    WindowInteractionState_BlockedByModalWindow,
    WindowInteractionState_NotResponding
  );
  {$EXTERNALSYM WindowInteractionState}

type
  PSOUNDSENTRY_WINDOWS_EFFECT = ^SOUNDSENTRY_WINDOWS_EFFECT;
  SOUNDSENTRY_WINDOWS_EFFECT = Cardinal;
  {$EXTERNALSYM SOUNDSENTRY_WINDOWS_EFFECT}
const
  // Constants for enum SOUNDSENTRY_WINDOWS_EFFECT
  SSWF_CUSTOM = $4 { 4 };
  {$EXTERNALSYM SSWF_CUSTOM}
  SSWF_DISPLAY = $3 { 3 };
  {$EXTERNALSYM SSWF_DISPLAY}
  SSWF_NONE = $0 { 0 };
  {$EXTERNALSYM SSWF_NONE}
  SSWF_TITLE = $1 { 1 };
  {$EXTERNALSYM SSWF_TITLE}
  SSWF_WINDOW = $2 { 2 };
  {$EXTERNALSYM SSWF_WINDOW}

type
  PScrollAmount = ^ScrollAmount;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-scrollamount</summary>
  ScrollAmount = (
    ScrollAmount_LargeDecrement,
    ScrollAmount_SmallDecrement,
    ScrollAmount_NoAmount,
    ScrollAmount_LargeIncrement,
    ScrollAmount_SmallIncrement
  );
  {$EXTERNALSYM ScrollAmount}

type
  PStructureChangeType = ^StructureChangeType;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-structurechangetype</summary>
  StructureChangeType = (
    StructureChangeType_ChildAdded,
    StructureChangeType_ChildRemoved,
    StructureChangeType_ChildrenInvalidated,
    StructureChangeType_ChildrenBulkAdded,
    StructureChangeType_ChildrenBulkRemoved,
    StructureChangeType_ChildrenReordered
  );
  {$EXTERNALSYM StructureChangeType}

type
  PUIA_ANNOTATIONTYPE = ^UIA_ANNOTATIONTYPE;
  UIA_ANNOTATIONTYPE = Cardinal;
  {$EXTERNALSYM UIA_ANNOTATIONTYPE}
const
  // Constants for enum UIA_ANNOTATIONTYPE
  AnnotationType_Unknown = $EA60 { 60000 };
  {$EXTERNALSYM AnnotationType_Unknown}
  AnnotationType_SpellingError = $EA61 { 60001 };
  {$EXTERNALSYM AnnotationType_SpellingError}
  AnnotationType_GrammarError = $EA62 { 60002 };
  {$EXTERNALSYM AnnotationType_GrammarError}
  AnnotationType_Comment = $EA63 { 60003 };
  {$EXTERNALSYM AnnotationType_Comment}
  AnnotationType_FormulaError = $EA64 { 60004 };
  {$EXTERNALSYM AnnotationType_FormulaError}
  AnnotationType_TrackChanges = $EA65 { 60005 };
  {$EXTERNALSYM AnnotationType_TrackChanges}
  AnnotationType_Header = $EA66 { 60006 };
  {$EXTERNALSYM AnnotationType_Header}
  AnnotationType_Footer = $EA67 { 60007 };
  {$EXTERNALSYM AnnotationType_Footer}
  AnnotationType_Highlighted = $EA68 { 60008 };
  {$EXTERNALSYM AnnotationType_Highlighted}
  AnnotationType_Endnote = $EA69 { 60009 };
  {$EXTERNALSYM AnnotationType_Endnote}
  AnnotationType_Footnote = $EA6A { 60010 };
  {$EXTERNALSYM AnnotationType_Footnote}
  AnnotationType_InsertionChange = $EA6B { 60011 };
  {$EXTERNALSYM AnnotationType_InsertionChange}
  AnnotationType_DeletionChange = $EA6C { 60012 };
  {$EXTERNALSYM AnnotationType_DeletionChange}
  AnnotationType_MoveChange = $EA6D { 60013 };
  {$EXTERNALSYM AnnotationType_MoveChange}
  AnnotationType_FormatChange = $EA6E { 60014 };
  {$EXTERNALSYM AnnotationType_FormatChange}
  AnnotationType_UnsyncedChange = $EA6F { 60015 };
  {$EXTERNALSYM AnnotationType_UnsyncedChange}
  AnnotationType_EditingLockedChange = $EA70 { 60016 };
  {$EXTERNALSYM AnnotationType_EditingLockedChange}
  AnnotationType_ExternalChange = $EA71 { 60017 };
  {$EXTERNALSYM AnnotationType_ExternalChange}
  AnnotationType_ConflictingChange = $EA72 { 60018 };
  {$EXTERNALSYM AnnotationType_ConflictingChange}
  AnnotationType_Author = $EA73 { 60019 };
  {$EXTERNALSYM AnnotationType_Author}
  AnnotationType_AdvancedProofingIssue = $EA74 { 60020 };
  {$EXTERNALSYM AnnotationType_AdvancedProofingIssue}
  AnnotationType_DataValidationError = $EA75 { 60021 };
  {$EXTERNALSYM AnnotationType_DataValidationError}
  AnnotationType_CircularReferenceError = $EA76 { 60022 };
  {$EXTERNALSYM AnnotationType_CircularReferenceError}
  AnnotationType_Mathematics = $EA77 { 60023 };
  {$EXTERNALSYM AnnotationType_Mathematics}
  AnnotationType_Sensitive = $EA78 { 60024 };
  {$EXTERNALSYM AnnotationType_Sensitive}

type
  PConditionType = ^ConditionType;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-conditiontype</summary>
  ConditionType = (
    ConditionType_True,
    ConditionType_False,
    ConditionType_Property,
    ConditionType_And,
    ConditionType_Or,
    ConditionType_Not
  );
  {$EXTERNALSYM ConditionType}

type
  PTextUnit = ^TextUnit;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-textunit</summary>
  TextUnit = (
    TextUnit_Character,
    TextUnit_Format,
    TextUnit_Word,
    TextUnit_Line,
    TextUnit_Paragraph,
    TextUnit_Page,
    TextUnit_Document
  );
  {$EXTERNALSYM TextUnit}

type
  PSOUNDSENTRY_FLAGS = ^SOUNDSENTRY_FLAGS;
  ///<remarks>This enumerated type is made up of bitwise flag values</remarks>
  SOUNDSENTRY_FLAGS = Cardinal;
  {$EXTERNALSYM SOUNDSENTRY_FLAGS}
const
  // Constants for enum SOUNDSENTRY_FLAGS
  SSF_SOUNDSENTRYON = $1 { 1 };
  {$EXTERNALSYM SSF_SOUNDSENTRYON}
  SSF_AVAILABLE = $2 { 2 };
  {$EXTERNALSYM SSF_AVAILABLE}
  SSF_INDICATOR = $4 { 4 };
  {$EXTERNALSYM SSF_INDICATOR}

type
  PTextDecorationLineStyle = ^TextDecorationLineStyle;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-textdecorationlinestyle</summary>
  TextDecorationLineStyle = Integer;
  {$EXTERNALSYM TextDecorationLineStyle}
const
  // Constants for enum TextDecorationLineStyle
  TextDecorationLineStyle_Other = $FFFFFFFF { -1 };
  {$EXTERNALSYM TextDecorationLineStyle_Other}
  TextDecorationLineStyle_None = $0 { 0 };
  {$EXTERNALSYM TextDecorationLineStyle_None}
  TextDecorationLineStyle_Single = $1 { 1 };
  {$EXTERNALSYM TextDecorationLineStyle_Single}
  TextDecorationLineStyle_WordsOnly = $2 { 2 };
  {$EXTERNALSYM TextDecorationLineStyle_WordsOnly}
  TextDecorationLineStyle_Double = $3 { 3 };
  {$EXTERNALSYM TextDecorationLineStyle_Double}
  TextDecorationLineStyle_Dot = $4 { 4 };
  {$EXTERNALSYM TextDecorationLineStyle_Dot}
  TextDecorationLineStyle_Dash = $5 { 5 };
  {$EXTERNALSYM TextDecorationLineStyle_Dash}
  TextDecorationLineStyle_DashDot = $6 { 6 };
  {$EXTERNALSYM TextDecorationLineStyle_DashDot}
  TextDecorationLineStyle_DashDotDot = $7 { 7 };
  {$EXTERNALSYM TextDecorationLineStyle_DashDotDot}
  TextDecorationLineStyle_Wavy = $8 { 8 };
  {$EXTERNALSYM TextDecorationLineStyle_Wavy}
  TextDecorationLineStyle_ThickSingle = $9 { 9 };
  {$EXTERNALSYM TextDecorationLineStyle_ThickSingle}
  TextDecorationLineStyle_DoubleWavy = $B { 11 };
  {$EXTERNALSYM TextDecorationLineStyle_DoubleWavy}
  TextDecorationLineStyle_ThickWavy = $C { 12 };
  {$EXTERNALSYM TextDecorationLineStyle_ThickWavy}
  TextDecorationLineStyle_LongDash = $D { 13 };
  {$EXTERNALSYM TextDecorationLineStyle_LongDash}
  TextDecorationLineStyle_ThickDash = $E { 14 };
  {$EXTERNALSYM TextDecorationLineStyle_ThickDash}
  TextDecorationLineStyle_ThickDashDot = $F { 15 };
  {$EXTERNALSYM TextDecorationLineStyle_ThickDashDot}
  TextDecorationLineStyle_ThickDashDotDot = $10 { 16 };
  {$EXTERNALSYM TextDecorationLineStyle_ThickDashDotDot}
  TextDecorationLineStyle_ThickDot = $11 { 17 };
  {$EXTERNALSYM TextDecorationLineStyle_ThickDot}
  TextDecorationLineStyle_ThickLongDash = $12 { 18 };
  {$EXTERNALSYM TextDecorationLineStyle_ThickLongDash}

type
  PExpandCollapseState = ^ExpandCollapseState;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-expandcollapsestate</summary>
  ExpandCollapseState = (
    ExpandCollapseState_Collapsed,
    ExpandCollapseState_Expanded,
    ExpandCollapseState_PartiallyExpanded,
    ExpandCollapseState_LeafNode
  );
  {$EXTERNALSYM ExpandCollapseState}

type
  PDockPosition = ^DockPosition;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-dockposition</summary>
  DockPosition = (
    DockPosition_Top,
    DockPosition_Left,
    DockPosition_Bottom,
    DockPosition_Right,
    DockPosition_Fill,
    DockPosition_None
  );
  {$EXTERNALSYM DockPosition}

type
  PProviderType = ^ProviderType;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-providertype</summary>
  ProviderType = (
    ProviderType_BaseHwnd,
    ProviderType_Proxy,
    ProviderType_NonClientArea
  );
  {$EXTERNALSYM ProviderType}

type
  PUIA_HEADINGLEVEL_ID = ^UIA_HEADINGLEVEL_ID;
  UIA_HEADINGLEVEL_ID = Cardinal;
  {$EXTERNALSYM UIA_HEADINGLEVEL_ID}
const
  // Constants for enum UIA_HEADINGLEVEL_ID
  HeadingLevel_None = $138B2 { 80050 };
  {$EXTERNALSYM HeadingLevel_None}
  HeadingLevel1 = $138B3 { 80051 };
  {$EXTERNALSYM HeadingLevel1}
  HeadingLevel2 = $138B4 { 80052 };
  {$EXTERNALSYM HeadingLevel2}
  HeadingLevel3 = $138B5 { 80053 };
  {$EXTERNALSYM HeadingLevel3}
  HeadingLevel4 = $138B6 { 80054 };
  {$EXTERNALSYM HeadingLevel4}
  HeadingLevel5 = $138B7 { 80055 };
  {$EXTERNALSYM HeadingLevel5}
  HeadingLevel6 = $138B8 { 80056 };
  {$EXTERNALSYM HeadingLevel6}
  HeadingLevel7 = $138B9 { 80057 };
  {$EXTERNALSYM HeadingLevel7}
  HeadingLevel8 = $138BA { 80058 };
  {$EXTERNALSYM HeadingLevel8}
  HeadingLevel9 = $138BB { 80059 };
  {$EXTERNALSYM HeadingLevel9}

type
  PRowOrColumnMajor = ^RowOrColumnMajor;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-roworcolumnmajor</summary>
  RowOrColumnMajor = (
    RowOrColumnMajor_RowMajor,
    RowOrColumnMajor_ColumnMajor,
    RowOrColumnMajor_Indeterminate
  );
  {$EXTERNALSYM RowOrColumnMajor}

type
  PUIA_PATTERN_ID = ^UIA_PATTERN_ID;
  UIA_PATTERN_ID = Cardinal;
  {$EXTERNALSYM UIA_PATTERN_ID}
const
  // Constants for enum UIA_PATTERN_ID
  UIA_InvokePatternId = $2710 { 10000 };
  {$EXTERNALSYM UIA_InvokePatternId}
  UIA_SelectionPatternId = $2711 { 10001 };
  {$EXTERNALSYM UIA_SelectionPatternId}
  UIA_ValuePatternId = $2712 { 10002 };
  {$EXTERNALSYM UIA_ValuePatternId}
  UIA_RangeValuePatternId = $2713 { 10003 };
  {$EXTERNALSYM UIA_RangeValuePatternId}
  UIA_ScrollPatternId = $2714 { 10004 };
  {$EXTERNALSYM UIA_ScrollPatternId}
  UIA_ExpandCollapsePatternId = $2715 { 10005 };
  {$EXTERNALSYM UIA_ExpandCollapsePatternId}
  UIA_GridPatternId = $2716 { 10006 };
  {$EXTERNALSYM UIA_GridPatternId}
  UIA_GridItemPatternId = $2717 { 10007 };
  {$EXTERNALSYM UIA_GridItemPatternId}
  UIA_MultipleViewPatternId = $2718 { 10008 };
  {$EXTERNALSYM UIA_MultipleViewPatternId}
  UIA_WindowPatternId = $2719 { 10009 };
  {$EXTERNALSYM UIA_WindowPatternId}
  UIA_SelectionItemPatternId = $271A { 10010 };
  {$EXTERNALSYM UIA_SelectionItemPatternId}
  UIA_DockPatternId = $271B { 10011 };
  {$EXTERNALSYM UIA_DockPatternId}
  UIA_TablePatternId = $271C { 10012 };
  {$EXTERNALSYM UIA_TablePatternId}
  UIA_TableItemPatternId = $271D { 10013 };
  {$EXTERNALSYM UIA_TableItemPatternId}
  UIA_TextPatternId = $271E { 10014 };
  {$EXTERNALSYM UIA_TextPatternId}
  UIA_TogglePatternId = $271F { 10015 };
  {$EXTERNALSYM UIA_TogglePatternId}
  UIA_TransformPatternId = $2720 { 10016 };
  {$EXTERNALSYM UIA_TransformPatternId}
  UIA_ScrollItemPatternId = $2721 { 10017 };
  {$EXTERNALSYM UIA_ScrollItemPatternId}
  UIA_LegacyIAccessiblePatternId = $2722 { 10018 };
  {$EXTERNALSYM UIA_LegacyIAccessiblePatternId}
  UIA_ItemContainerPatternId = $2723 { 10019 };
  {$EXTERNALSYM UIA_ItemContainerPatternId}
  UIA_VirtualizedItemPatternId = $2724 { 10020 };
  {$EXTERNALSYM UIA_VirtualizedItemPatternId}
  UIA_SynchronizedInputPatternId = $2725 { 10021 };
  {$EXTERNALSYM UIA_SynchronizedInputPatternId}
  UIA_ObjectModelPatternId = $2726 { 10022 };
  {$EXTERNALSYM UIA_ObjectModelPatternId}
  UIA_AnnotationPatternId = $2727 { 10023 };
  {$EXTERNALSYM UIA_AnnotationPatternId}
  UIA_TextPattern2Id = $2728 { 10024 };
  {$EXTERNALSYM UIA_TextPattern2Id}
  UIA_StylesPatternId = $2729 { 10025 };
  {$EXTERNALSYM UIA_StylesPatternId}
  UIA_SpreadsheetPatternId = $272A { 10026 };
  {$EXTERNALSYM UIA_SpreadsheetPatternId}
  UIA_SpreadsheetItemPatternId = $272B { 10027 };
  {$EXTERNALSYM UIA_SpreadsheetItemPatternId}
  UIA_TransformPattern2Id = $272C { 10028 };
  {$EXTERNALSYM UIA_TransformPattern2Id}
  UIA_TextChildPatternId = $272D { 10029 };
  {$EXTERNALSYM UIA_TextChildPatternId}
  UIA_DragPatternId = $272E { 10030 };
  {$EXTERNALSYM UIA_DragPatternId}
  UIA_DropTargetPatternId = $272F { 10031 };
  {$EXTERNALSYM UIA_DropTargetPatternId}
  UIA_TextEditPatternId = $2730 { 10032 };
  {$EXTERNALSYM UIA_TextEditPatternId}
  UIA_CustomNavigationPatternId = $2731 { 10033 };
  {$EXTERNALSYM UIA_CustomNavigationPatternId}
  UIA_SelectionPattern2Id = $2732 { 10034 };
  {$EXTERNALSYM UIA_SelectionPattern2Id}

type
  PUIA_PROPERTY_ID = ^UIA_PROPERTY_ID;
  UIA_PROPERTY_ID = Cardinal;
  {$EXTERNALSYM UIA_PROPERTY_ID}
const
  // Constants for enum UIA_PROPERTY_ID
  UIA_RuntimeIdPropertyId = $7530 { 30000 };
  {$EXTERNALSYM UIA_RuntimeIdPropertyId}
  UIA_BoundingRectanglePropertyId = $7531 { 30001 };
  {$EXTERNALSYM UIA_BoundingRectanglePropertyId}
  UIA_ProcessIdPropertyId = $7532 { 30002 };
  {$EXTERNALSYM UIA_ProcessIdPropertyId}
  UIA_ControlTypePropertyId = $7533 { 30003 };
  {$EXTERNALSYM UIA_ControlTypePropertyId}
  UIA_LocalizedControlTypePropertyId = $7534 { 30004 };
  {$EXTERNALSYM UIA_LocalizedControlTypePropertyId}
  UIA_NamePropertyId = $7535 { 30005 };
  {$EXTERNALSYM UIA_NamePropertyId}
  UIA_AcceleratorKeyPropertyId = $7536 { 30006 };
  {$EXTERNALSYM UIA_AcceleratorKeyPropertyId}
  UIA_AccessKeyPropertyId = $7537 { 30007 };
  {$EXTERNALSYM UIA_AccessKeyPropertyId}
  UIA_HasKeyboardFocusPropertyId = $7538 { 30008 };
  {$EXTERNALSYM UIA_HasKeyboardFocusPropertyId}
  UIA_IsKeyboardFocusablePropertyId = $7539 { 30009 };
  {$EXTERNALSYM UIA_IsKeyboardFocusablePropertyId}
  UIA_IsEnabledPropertyId = $753A { 30010 };
  {$EXTERNALSYM UIA_IsEnabledPropertyId}
  UIA_AutomationIdPropertyId = $753B { 30011 };
  {$EXTERNALSYM UIA_AutomationIdPropertyId}
  UIA_ClassNamePropertyId = $753C { 30012 };
  {$EXTERNALSYM UIA_ClassNamePropertyId}
  UIA_HelpTextPropertyId = $753D { 30013 };
  {$EXTERNALSYM UIA_HelpTextPropertyId}
  UIA_ClickablePointPropertyId = $753E { 30014 };
  {$EXTERNALSYM UIA_ClickablePointPropertyId}
  UIA_CulturePropertyId = $753F { 30015 };
  {$EXTERNALSYM UIA_CulturePropertyId}
  UIA_IsControlElementPropertyId = $7540 { 30016 };
  {$EXTERNALSYM UIA_IsControlElementPropertyId}
  UIA_IsContentElementPropertyId = $7541 { 30017 };
  {$EXTERNALSYM UIA_IsContentElementPropertyId}
  UIA_LabeledByPropertyId = $7542 { 30018 };
  {$EXTERNALSYM UIA_LabeledByPropertyId}
  UIA_IsPasswordPropertyId = $7543 { 30019 };
  {$EXTERNALSYM UIA_IsPasswordPropertyId}
  UIA_NativeWindowHandlePropertyId = $7544 { 30020 };
  {$EXTERNALSYM UIA_NativeWindowHandlePropertyId}
  UIA_ItemTypePropertyId = $7545 { 30021 };
  {$EXTERNALSYM UIA_ItemTypePropertyId}
  UIA_IsOffscreenPropertyId = $7546 { 30022 };
  {$EXTERNALSYM UIA_IsOffscreenPropertyId}
  UIA_OrientationPropertyId = $7547 { 30023 };
  {$EXTERNALSYM UIA_OrientationPropertyId}
  UIA_FrameworkIdPropertyId = $7548 { 30024 };
  {$EXTERNALSYM UIA_FrameworkIdPropertyId}
  UIA_IsRequiredForFormPropertyId = $7549 { 30025 };
  {$EXTERNALSYM UIA_IsRequiredForFormPropertyId}
  UIA_ItemStatusPropertyId = $754A { 30026 };
  {$EXTERNALSYM UIA_ItemStatusPropertyId}
  UIA_IsDockPatternAvailablePropertyId = $754B { 30027 };
  {$EXTERNALSYM UIA_IsDockPatternAvailablePropertyId}
  UIA_IsExpandCollapsePatternAvailablePropertyId = $754C { 30028 };
  {$EXTERNALSYM UIA_IsExpandCollapsePatternAvailablePropertyId}
  UIA_IsGridItemPatternAvailablePropertyId = $754D { 30029 };
  {$EXTERNALSYM UIA_IsGridItemPatternAvailablePropertyId}
  UIA_IsGridPatternAvailablePropertyId = $754E { 30030 };
  {$EXTERNALSYM UIA_IsGridPatternAvailablePropertyId}
  UIA_IsInvokePatternAvailablePropertyId = $754F { 30031 };
  {$EXTERNALSYM UIA_IsInvokePatternAvailablePropertyId}
  UIA_IsMultipleViewPatternAvailablePropertyId = $7550 { 30032 };
  {$EXTERNALSYM UIA_IsMultipleViewPatternAvailablePropertyId}
  UIA_IsRangeValuePatternAvailablePropertyId = $7551 { 30033 };
  {$EXTERNALSYM UIA_IsRangeValuePatternAvailablePropertyId}
  UIA_IsScrollPatternAvailablePropertyId = $7552 { 30034 };
  {$EXTERNALSYM UIA_IsScrollPatternAvailablePropertyId}
  UIA_IsScrollItemPatternAvailablePropertyId = $7553 { 30035 };
  {$EXTERNALSYM UIA_IsScrollItemPatternAvailablePropertyId}
  UIA_IsSelectionItemPatternAvailablePropertyId = $7554 { 30036 };
  {$EXTERNALSYM UIA_IsSelectionItemPatternAvailablePropertyId}
  UIA_IsSelectionPatternAvailablePropertyId = $7555 { 30037 };
  {$EXTERNALSYM UIA_IsSelectionPatternAvailablePropertyId}
  UIA_IsTablePatternAvailablePropertyId = $7556 { 30038 };
  {$EXTERNALSYM UIA_IsTablePatternAvailablePropertyId}
  UIA_IsTableItemPatternAvailablePropertyId = $7557 { 30039 };
  {$EXTERNALSYM UIA_IsTableItemPatternAvailablePropertyId}
  UIA_IsTextPatternAvailablePropertyId = $7558 { 30040 };
  {$EXTERNALSYM UIA_IsTextPatternAvailablePropertyId}
  UIA_IsTogglePatternAvailablePropertyId = $7559 { 30041 };
  {$EXTERNALSYM UIA_IsTogglePatternAvailablePropertyId}
  UIA_IsTransformPatternAvailablePropertyId = $755A { 30042 };
  {$EXTERNALSYM UIA_IsTransformPatternAvailablePropertyId}
  UIA_IsValuePatternAvailablePropertyId = $755B { 30043 };
  {$EXTERNALSYM UIA_IsValuePatternAvailablePropertyId}
  UIA_IsWindowPatternAvailablePropertyId = $755C { 30044 };
  {$EXTERNALSYM UIA_IsWindowPatternAvailablePropertyId}
  UIA_ValueValuePropertyId = $755D { 30045 };
  {$EXTERNALSYM UIA_ValueValuePropertyId}
  UIA_ValueIsReadOnlyPropertyId = $755E { 30046 };
  {$EXTERNALSYM UIA_ValueIsReadOnlyPropertyId}
  UIA_RangeValueValuePropertyId = $755F { 30047 };
  {$EXTERNALSYM UIA_RangeValueValuePropertyId}
  UIA_RangeValueIsReadOnlyPropertyId = $7560 { 30048 };
  {$EXTERNALSYM UIA_RangeValueIsReadOnlyPropertyId}
  UIA_RangeValueMinimumPropertyId = $7561 { 30049 };
  {$EXTERNALSYM UIA_RangeValueMinimumPropertyId}
  UIA_RangeValueMaximumPropertyId = $7562 { 30050 };
  {$EXTERNALSYM UIA_RangeValueMaximumPropertyId}
  UIA_RangeValueLargeChangePropertyId = $7563 { 30051 };
  {$EXTERNALSYM UIA_RangeValueLargeChangePropertyId}
  UIA_RangeValueSmallChangePropertyId = $7564 { 30052 };
  {$EXTERNALSYM UIA_RangeValueSmallChangePropertyId}
  UIA_ScrollHorizontalScrollPercentPropertyId = $7565 { 30053 };
  {$EXTERNALSYM UIA_ScrollHorizontalScrollPercentPropertyId}
  UIA_ScrollHorizontalViewSizePropertyId = $7566 { 30054 };
  {$EXTERNALSYM UIA_ScrollHorizontalViewSizePropertyId}
  UIA_ScrollVerticalScrollPercentPropertyId = $7567 { 30055 };
  {$EXTERNALSYM UIA_ScrollVerticalScrollPercentPropertyId}
  UIA_ScrollVerticalViewSizePropertyId = $7568 { 30056 };
  {$EXTERNALSYM UIA_ScrollVerticalViewSizePropertyId}
  UIA_ScrollHorizontallyScrollablePropertyId = $7569 { 30057 };
  {$EXTERNALSYM UIA_ScrollHorizontallyScrollablePropertyId}
  UIA_ScrollVerticallyScrollablePropertyId = $756A { 30058 };
  {$EXTERNALSYM UIA_ScrollVerticallyScrollablePropertyId}
  UIA_SelectionSelectionPropertyId = $756B { 30059 };
  {$EXTERNALSYM UIA_SelectionSelectionPropertyId}
  UIA_SelectionCanSelectMultiplePropertyId = $756C { 30060 };
  {$EXTERNALSYM UIA_SelectionCanSelectMultiplePropertyId}
  UIA_SelectionIsSelectionRequiredPropertyId = $756D { 30061 };
  {$EXTERNALSYM UIA_SelectionIsSelectionRequiredPropertyId}
  UIA_GridRowCountPropertyId = $756E { 30062 };
  {$EXTERNALSYM UIA_GridRowCountPropertyId}
  UIA_GridColumnCountPropertyId = $756F { 30063 };
  {$EXTERNALSYM UIA_GridColumnCountPropertyId}
  UIA_GridItemRowPropertyId = $7570 { 30064 };
  {$EXTERNALSYM UIA_GridItemRowPropertyId}
  UIA_GridItemColumnPropertyId = $7571 { 30065 };
  {$EXTERNALSYM UIA_GridItemColumnPropertyId}
  UIA_GridItemRowSpanPropertyId = $7572 { 30066 };
  {$EXTERNALSYM UIA_GridItemRowSpanPropertyId}
  UIA_GridItemColumnSpanPropertyId = $7573 { 30067 };
  {$EXTERNALSYM UIA_GridItemColumnSpanPropertyId}
  UIA_GridItemContainingGridPropertyId = $7574 { 30068 };
  {$EXTERNALSYM UIA_GridItemContainingGridPropertyId}
  UIA_DockDockPositionPropertyId = $7575 { 30069 };
  {$EXTERNALSYM UIA_DockDockPositionPropertyId}
  UIA_ExpandCollapseExpandCollapseStatePropertyId = $7576 { 30070 };
  {$EXTERNALSYM UIA_ExpandCollapseExpandCollapseStatePropertyId}
  UIA_MultipleViewCurrentViewPropertyId = $7577 { 30071 };
  {$EXTERNALSYM UIA_MultipleViewCurrentViewPropertyId}
  UIA_MultipleViewSupportedViewsPropertyId = $7578 { 30072 };
  {$EXTERNALSYM UIA_MultipleViewSupportedViewsPropertyId}
  UIA_WindowCanMaximizePropertyId = $7579 { 30073 };
  {$EXTERNALSYM UIA_WindowCanMaximizePropertyId}
  UIA_WindowCanMinimizePropertyId = $757A { 30074 };
  {$EXTERNALSYM UIA_WindowCanMinimizePropertyId}
  UIA_WindowWindowVisualStatePropertyId = $757B { 30075 };
  {$EXTERNALSYM UIA_WindowWindowVisualStatePropertyId}
  UIA_WindowWindowInteractionStatePropertyId = $757C { 30076 };
  {$EXTERNALSYM UIA_WindowWindowInteractionStatePropertyId}
  UIA_WindowIsModalPropertyId = $757D { 30077 };
  {$EXTERNALSYM UIA_WindowIsModalPropertyId}
  UIA_WindowIsTopmostPropertyId = $757E { 30078 };
  {$EXTERNALSYM UIA_WindowIsTopmostPropertyId}
  UIA_SelectionItemIsSelectedPropertyId = $757F { 30079 };
  {$EXTERNALSYM UIA_SelectionItemIsSelectedPropertyId}
  UIA_SelectionItemSelectionContainerPropertyId = $7580 { 30080 };
  {$EXTERNALSYM UIA_SelectionItemSelectionContainerPropertyId}
  UIA_TableRowHeadersPropertyId = $7581 { 30081 };
  {$EXTERNALSYM UIA_TableRowHeadersPropertyId}
  UIA_TableColumnHeadersPropertyId = $7582 { 30082 };
  {$EXTERNALSYM UIA_TableColumnHeadersPropertyId}
  UIA_TableRowOrColumnMajorPropertyId = $7583 { 30083 };
  {$EXTERNALSYM UIA_TableRowOrColumnMajorPropertyId}
  UIA_TableItemRowHeaderItemsPropertyId = $7584 { 30084 };
  {$EXTERNALSYM UIA_TableItemRowHeaderItemsPropertyId}
  UIA_TableItemColumnHeaderItemsPropertyId = $7585 { 30085 };
  {$EXTERNALSYM UIA_TableItemColumnHeaderItemsPropertyId}
  UIA_ToggleToggleStatePropertyId = $7586 { 30086 };
  {$EXTERNALSYM UIA_ToggleToggleStatePropertyId}
  UIA_TransformCanMovePropertyId = $7587 { 30087 };
  {$EXTERNALSYM UIA_TransformCanMovePropertyId}
  UIA_TransformCanResizePropertyId = $7588 { 30088 };
  {$EXTERNALSYM UIA_TransformCanResizePropertyId}
  UIA_TransformCanRotatePropertyId = $7589 { 30089 };
  {$EXTERNALSYM UIA_TransformCanRotatePropertyId}
  UIA_IsLegacyIAccessiblePatternAvailablePropertyId = $758A { 30090 };
  {$EXTERNALSYM UIA_IsLegacyIAccessiblePatternAvailablePropertyId}
  UIA_LegacyIAccessibleChildIdPropertyId = $758B { 30091 };
  {$EXTERNALSYM UIA_LegacyIAccessibleChildIdPropertyId}
  UIA_LegacyIAccessibleNamePropertyId = $758C { 30092 };
  {$EXTERNALSYM UIA_LegacyIAccessibleNamePropertyId}
  UIA_LegacyIAccessibleValuePropertyId = $758D { 30093 };
  {$EXTERNALSYM UIA_LegacyIAccessibleValuePropertyId}
  UIA_LegacyIAccessibleDescriptionPropertyId = $758E { 30094 };
  {$EXTERNALSYM UIA_LegacyIAccessibleDescriptionPropertyId}
  UIA_LegacyIAccessibleRolePropertyId = $758F { 30095 };
  {$EXTERNALSYM UIA_LegacyIAccessibleRolePropertyId}
  UIA_LegacyIAccessibleStatePropertyId = $7590 { 30096 };
  {$EXTERNALSYM UIA_LegacyIAccessibleStatePropertyId}
  UIA_LegacyIAccessibleHelpPropertyId = $7591 { 30097 };
  {$EXTERNALSYM UIA_LegacyIAccessibleHelpPropertyId}
  UIA_LegacyIAccessibleKeyboardShortcutPropertyId = $7592 { 30098 };
  {$EXTERNALSYM UIA_LegacyIAccessibleKeyboardShortcutPropertyId}
  UIA_LegacyIAccessibleSelectionPropertyId = $7593 { 30099 };
  {$EXTERNALSYM UIA_LegacyIAccessibleSelectionPropertyId}
  UIA_LegacyIAccessibleDefaultActionPropertyId = $7594 { 30100 };
  {$EXTERNALSYM UIA_LegacyIAccessibleDefaultActionPropertyId}
  UIA_AriaRolePropertyId = $7595 { 30101 };
  {$EXTERNALSYM UIA_AriaRolePropertyId}
  UIA_AriaPropertiesPropertyId = $7596 { 30102 };
  {$EXTERNALSYM UIA_AriaPropertiesPropertyId}
  UIA_IsDataValidForFormPropertyId = $7597 { 30103 };
  {$EXTERNALSYM UIA_IsDataValidForFormPropertyId}
  UIA_ControllerForPropertyId = $7598 { 30104 };
  {$EXTERNALSYM UIA_ControllerForPropertyId}
  UIA_DescribedByPropertyId = $7599 { 30105 };
  {$EXTERNALSYM UIA_DescribedByPropertyId}
  UIA_FlowsToPropertyId = $759A { 30106 };
  {$EXTERNALSYM UIA_FlowsToPropertyId}
  UIA_ProviderDescriptionPropertyId = $759B { 30107 };
  {$EXTERNALSYM UIA_ProviderDescriptionPropertyId}
  UIA_IsItemContainerPatternAvailablePropertyId = $759C { 30108 };
  {$EXTERNALSYM UIA_IsItemContainerPatternAvailablePropertyId}
  UIA_IsVirtualizedItemPatternAvailablePropertyId = $759D { 30109 };
  {$EXTERNALSYM UIA_IsVirtualizedItemPatternAvailablePropertyId}
  UIA_IsSynchronizedInputPatternAvailablePropertyId = $759E { 30110 };
  {$EXTERNALSYM UIA_IsSynchronizedInputPatternAvailablePropertyId}
  UIA_OptimizeForVisualContentPropertyId = $759F { 30111 };
  {$EXTERNALSYM UIA_OptimizeForVisualContentPropertyId}
  UIA_IsObjectModelPatternAvailablePropertyId = $75A0 { 30112 };
  {$EXTERNALSYM UIA_IsObjectModelPatternAvailablePropertyId}
  UIA_AnnotationAnnotationTypeIdPropertyId = $75A1 { 30113 };
  {$EXTERNALSYM UIA_AnnotationAnnotationTypeIdPropertyId}
  UIA_AnnotationAnnotationTypeNamePropertyId = $75A2 { 30114 };
  {$EXTERNALSYM UIA_AnnotationAnnotationTypeNamePropertyId}
  UIA_AnnotationAuthorPropertyId = $75A3 { 30115 };
  {$EXTERNALSYM UIA_AnnotationAuthorPropertyId}
  UIA_AnnotationDateTimePropertyId = $75A4 { 30116 };
  {$EXTERNALSYM UIA_AnnotationDateTimePropertyId}
  UIA_AnnotationTargetPropertyId = $75A5 { 30117 };
  {$EXTERNALSYM UIA_AnnotationTargetPropertyId}
  UIA_IsAnnotationPatternAvailablePropertyId = $75A6 { 30118 };
  {$EXTERNALSYM UIA_IsAnnotationPatternAvailablePropertyId}
  UIA_IsTextPattern2AvailablePropertyId = $75A7 { 30119 };
  {$EXTERNALSYM UIA_IsTextPattern2AvailablePropertyId}
  UIA_StylesStyleIdPropertyId = $75A8 { 30120 };
  {$EXTERNALSYM UIA_StylesStyleIdPropertyId}
  UIA_StylesStyleNamePropertyId = $75A9 { 30121 };
  {$EXTERNALSYM UIA_StylesStyleNamePropertyId}
  UIA_StylesFillColorPropertyId = $75AA { 30122 };
  {$EXTERNALSYM UIA_StylesFillColorPropertyId}
  UIA_StylesFillPatternStylePropertyId = $75AB { 30123 };
  {$EXTERNALSYM UIA_StylesFillPatternStylePropertyId}
  UIA_StylesShapePropertyId = $75AC { 30124 };
  {$EXTERNALSYM UIA_StylesShapePropertyId}
  UIA_StylesFillPatternColorPropertyId = $75AD { 30125 };
  {$EXTERNALSYM UIA_StylesFillPatternColorPropertyId}
  UIA_StylesExtendedPropertiesPropertyId = $75AE { 30126 };
  {$EXTERNALSYM UIA_StylesExtendedPropertiesPropertyId}
  UIA_IsStylesPatternAvailablePropertyId = $75AF { 30127 };
  {$EXTERNALSYM UIA_IsStylesPatternAvailablePropertyId}
  UIA_IsSpreadsheetPatternAvailablePropertyId = $75B0 { 30128 };
  {$EXTERNALSYM UIA_IsSpreadsheetPatternAvailablePropertyId}
  UIA_SpreadsheetItemFormulaPropertyId = $75B1 { 30129 };
  {$EXTERNALSYM UIA_SpreadsheetItemFormulaPropertyId}
  UIA_SpreadsheetItemAnnotationObjectsPropertyId = $75B2 { 30130 };
  {$EXTERNALSYM UIA_SpreadsheetItemAnnotationObjectsPropertyId}
  UIA_SpreadsheetItemAnnotationTypesPropertyId = $75B3 { 30131 };
  {$EXTERNALSYM UIA_SpreadsheetItemAnnotationTypesPropertyId}
  UIA_IsSpreadsheetItemPatternAvailablePropertyId = $75B4 { 30132 };
  {$EXTERNALSYM UIA_IsSpreadsheetItemPatternAvailablePropertyId}
  UIA_Transform2CanZoomPropertyId = $75B5 { 30133 };
  {$EXTERNALSYM UIA_Transform2CanZoomPropertyId}
  UIA_IsTransformPattern2AvailablePropertyId = $75B6 { 30134 };
  {$EXTERNALSYM UIA_IsTransformPattern2AvailablePropertyId}
  UIA_LiveSettingPropertyId = $75B7 { 30135 };
  {$EXTERNALSYM UIA_LiveSettingPropertyId}
  UIA_IsTextChildPatternAvailablePropertyId = $75B8 { 30136 };
  {$EXTERNALSYM UIA_IsTextChildPatternAvailablePropertyId}
  UIA_IsDragPatternAvailablePropertyId = $75B9 { 30137 };
  {$EXTERNALSYM UIA_IsDragPatternAvailablePropertyId}
  UIA_DragIsGrabbedPropertyId = $75BA { 30138 };
  {$EXTERNALSYM UIA_DragIsGrabbedPropertyId}
  UIA_DragDropEffectPropertyId = $75BB { 30139 };
  {$EXTERNALSYM UIA_DragDropEffectPropertyId}
  UIA_DragDropEffectsPropertyId = $75BC { 30140 };
  {$EXTERNALSYM UIA_DragDropEffectsPropertyId}
  UIA_IsDropTargetPatternAvailablePropertyId = $75BD { 30141 };
  {$EXTERNALSYM UIA_IsDropTargetPatternAvailablePropertyId}
  UIA_DropTargetDropTargetEffectPropertyId = $75BE { 30142 };
  {$EXTERNALSYM UIA_DropTargetDropTargetEffectPropertyId}
  UIA_DropTargetDropTargetEffectsPropertyId = $75BF { 30143 };
  {$EXTERNALSYM UIA_DropTargetDropTargetEffectsPropertyId}
  UIA_DragGrabbedItemsPropertyId = $75C0 { 30144 };
  {$EXTERNALSYM UIA_DragGrabbedItemsPropertyId}
  UIA_Transform2ZoomLevelPropertyId = $75C1 { 30145 };
  {$EXTERNALSYM UIA_Transform2ZoomLevelPropertyId}
  UIA_Transform2ZoomMinimumPropertyId = $75C2 { 30146 };
  {$EXTERNALSYM UIA_Transform2ZoomMinimumPropertyId}
  UIA_Transform2ZoomMaximumPropertyId = $75C3 { 30147 };
  {$EXTERNALSYM UIA_Transform2ZoomMaximumPropertyId}
  UIA_FlowsFromPropertyId = $75C4 { 30148 };
  {$EXTERNALSYM UIA_FlowsFromPropertyId}
  UIA_IsTextEditPatternAvailablePropertyId = $75C5 { 30149 };
  {$EXTERNALSYM UIA_IsTextEditPatternAvailablePropertyId}
  UIA_IsPeripheralPropertyId = $75C6 { 30150 };
  {$EXTERNALSYM UIA_IsPeripheralPropertyId}
  UIA_IsCustomNavigationPatternAvailablePropertyId = $75C7 { 30151 };
  {$EXTERNALSYM UIA_IsCustomNavigationPatternAvailablePropertyId}
  UIA_PositionInSetPropertyId = $75C8 { 30152 };
  {$EXTERNALSYM UIA_PositionInSetPropertyId}
  UIA_SizeOfSetPropertyId = $75C9 { 30153 };
  {$EXTERNALSYM UIA_SizeOfSetPropertyId}
  UIA_LevelPropertyId = $75CA { 30154 };
  {$EXTERNALSYM UIA_LevelPropertyId}
  UIA_AnnotationTypesPropertyId = $75CB { 30155 };
  {$EXTERNALSYM UIA_AnnotationTypesPropertyId}
  UIA_AnnotationObjectsPropertyId = $75CC { 30156 };
  {$EXTERNALSYM UIA_AnnotationObjectsPropertyId}
  UIA_LandmarkTypePropertyId = $75CD { 30157 };
  {$EXTERNALSYM UIA_LandmarkTypePropertyId}
  UIA_LocalizedLandmarkTypePropertyId = $75CE { 30158 };
  {$EXTERNALSYM UIA_LocalizedLandmarkTypePropertyId}
  UIA_FullDescriptionPropertyId = $75CF { 30159 };
  {$EXTERNALSYM UIA_FullDescriptionPropertyId}
  UIA_FillColorPropertyId = $75D0 { 30160 };
  {$EXTERNALSYM UIA_FillColorPropertyId}
  UIA_OutlineColorPropertyId = $75D1 { 30161 };
  {$EXTERNALSYM UIA_OutlineColorPropertyId}
  UIA_FillTypePropertyId = $75D2 { 30162 };
  {$EXTERNALSYM UIA_FillTypePropertyId}
  UIA_VisualEffectsPropertyId = $75D3 { 30163 };
  {$EXTERNALSYM UIA_VisualEffectsPropertyId}
  UIA_OutlineThicknessPropertyId = $75D4 { 30164 };
  {$EXTERNALSYM UIA_OutlineThicknessPropertyId}
  UIA_CenterPointPropertyId = $75D5 { 30165 };
  {$EXTERNALSYM UIA_CenterPointPropertyId}
  UIA_RotationPropertyId = $75D6 { 30166 };
  {$EXTERNALSYM UIA_RotationPropertyId}
  UIA_SizePropertyId = $75D7 { 30167 };
  {$EXTERNALSYM UIA_SizePropertyId}
  UIA_IsSelectionPattern2AvailablePropertyId = $75D8 { 30168 };
  {$EXTERNALSYM UIA_IsSelectionPattern2AvailablePropertyId}
  UIA_Selection2FirstSelectedItemPropertyId = $75D9 { 30169 };
  {$EXTERNALSYM UIA_Selection2FirstSelectedItemPropertyId}
  UIA_Selection2LastSelectedItemPropertyId = $75DA { 30170 };
  {$EXTERNALSYM UIA_Selection2LastSelectedItemPropertyId}
  UIA_Selection2CurrentSelectedItemPropertyId = $75DB { 30171 };
  {$EXTERNALSYM UIA_Selection2CurrentSelectedItemPropertyId}
  UIA_Selection2ItemCountPropertyId = $75DC { 30172 };
  {$EXTERNALSYM UIA_Selection2ItemCountPropertyId}
  UIA_HeadingLevelPropertyId = $75DD { 30173 };
  {$EXTERNALSYM UIA_HeadingLevelPropertyId}
  UIA_IsDialogPropertyId = $75DE { 30174 };
  {$EXTERNALSYM UIA_IsDialogPropertyId}

type
  PActiveEnd = ^ActiveEnd;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-activeend</summary>
  ActiveEnd = (
    ActiveEnd_None,
    ActiveEnd_Start,
    ActiveEnd_End
  );
  {$EXTERNALSYM ActiveEnd}

type
  PWindowVisualState = ^WindowVisualState;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-windowvisualstate</summary>
  WindowVisualState = (
    WindowVisualState_Normal,
    WindowVisualState_Maximized,
    WindowVisualState_Minimized
  );
  {$EXTERNALSYM WindowVisualState}

type
  POrientationType = ^OrientationType;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-orientationtype</summary>
  OrientationType = (
    OrientationType_None,
    OrientationType_Horizontal,
    OrientationType_Vertical
  );
  {$EXTERNALSYM OrientationType}

type
  PUIAutomationType = ^UIAutomationType;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-uiautomationtype</summary>
  ///<remarks>This enumerated type is made up of bitwise flag values</remarks>
  UIAutomationType = Integer;
  {$EXTERNALSYM UIAutomationType}
const
  // Constants for enum UIAutomationType
  UIAutomationType_Int = $1 { 1 };
  {$EXTERNALSYM UIAutomationType_Int}
  UIAutomationType_Bool = $2 { 2 };
  {$EXTERNALSYM UIAutomationType_Bool}
  UIAutomationType_String = $3 { 3 };
  {$EXTERNALSYM UIAutomationType_String}
  UIAutomationType_Double = $4 { 4 };
  {$EXTERNALSYM UIAutomationType_Double}
  UIAutomationType_Point = $5 { 5 };
  {$EXTERNALSYM UIAutomationType_Point}
  UIAutomationType_Rect = $6 { 6 };
  {$EXTERNALSYM UIAutomationType_Rect}
  UIAutomationType_Element = $7 { 7 };
  {$EXTERNALSYM UIAutomationType_Element}
  UIAutomationType_Array = $10000 { 65536 };
  {$EXTERNALSYM UIAutomationType_Array}
  UIAutomationType_Out = $20000 { 131072 };
  {$EXTERNALSYM UIAutomationType_Out}
  UIAutomationType_IntArray = $10001 { 65537 };
  {$EXTERNALSYM UIAutomationType_IntArray}
  UIAutomationType_BoolArray = $10002 { 65538 };
  {$EXTERNALSYM UIAutomationType_BoolArray}
  UIAutomationType_StringArray = $10003 { 65539 };
  {$EXTERNALSYM UIAutomationType_StringArray}
  UIAutomationType_DoubleArray = $10004 { 65540 };
  {$EXTERNALSYM UIAutomationType_DoubleArray}
  UIAutomationType_PointArray = $10005 { 65541 };
  {$EXTERNALSYM UIAutomationType_PointArray}
  UIAutomationType_RectArray = $10006 { 65542 };
  {$EXTERNALSYM UIAutomationType_RectArray}
  UIAutomationType_ElementArray = $10007 { 65543 };
  {$EXTERNALSYM UIAutomationType_ElementArray}
  UIAutomationType_OutInt = $20001 { 131073 };
  {$EXTERNALSYM UIAutomationType_OutInt}
  UIAutomationType_OutBool = $20002 { 131074 };
  {$EXTERNALSYM UIAutomationType_OutBool}
  UIAutomationType_OutString = $20003 { 131075 };
  {$EXTERNALSYM UIAutomationType_OutString}
  UIAutomationType_OutDouble = $20004 { 131076 };
  {$EXTERNALSYM UIAutomationType_OutDouble}
  UIAutomationType_OutPoint = $20005 { 131077 };
  {$EXTERNALSYM UIAutomationType_OutPoint}
  UIAutomationType_OutRect = $20006 { 131078 };
  {$EXTERNALSYM UIAutomationType_OutRect}
  UIAutomationType_OutElement = $20007 { 131079 };
  {$EXTERNALSYM UIAutomationType_OutElement}
  UIAutomationType_OutIntArray = $30001 { 196609 };
  {$EXTERNALSYM UIAutomationType_OutIntArray}
  UIAutomationType_OutBoolArray = $30002 { 196610 };
  {$EXTERNALSYM UIAutomationType_OutBoolArray}
  UIAutomationType_OutStringArray = $30003 { 196611 };
  {$EXTERNALSYM UIAutomationType_OutStringArray}
  UIAutomationType_OutDoubleArray = $30004 { 196612 };
  {$EXTERNALSYM UIAutomationType_OutDoubleArray}
  UIAutomationType_OutPointArray = $30005 { 196613 };
  {$EXTERNALSYM UIAutomationType_OutPointArray}
  UIAutomationType_OutRectArray = $30006 { 196614 };
  {$EXTERNALSYM UIAutomationType_OutRectArray}
  UIAutomationType_OutElementArray = $30007 { 196615 };
  {$EXTERNALSYM UIAutomationType_OutElementArray}

type
  PSayAsInterpretAs = ^SayAsInterpretAs;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-sayasinterpretas</summary>
  SayAsInterpretAs = (
    SayAsInterpretAs_None,
    SayAsInterpretAs_Spell,
    SayAsInterpretAs_Cardinal,
    SayAsInterpretAs_Ordinal,
    SayAsInterpretAs_Number,
    SayAsInterpretAs_Date,
    SayAsInterpretAs_Time,
    SayAsInterpretAs_Telephone,
    SayAsInterpretAs_Currency,
    SayAsInterpretAs_Net,
    SayAsInterpretAs_Url,
    SayAsInterpretAs_Address,
    SayAsInterpretAs_Alphanumeric,
    SayAsInterpretAs_Name,
    SayAsInterpretAs_Media,
    SayAsInterpretAs_Date_MonthDayYear,
    SayAsInterpretAs_Date_DayMonthYear,
    SayAsInterpretAs_Date_YearMonthDay,
    SayAsInterpretAs_Date_YearMonth,
    SayAsInterpretAs_Date_MonthYear,
    SayAsInterpretAs_Date_DayMonth,
    SayAsInterpretAs_Date_MonthDay,
    SayAsInterpretAs_Date_Year,
    SayAsInterpretAs_Time_HoursMinutesSeconds12,
    SayAsInterpretAs_Time_HoursMinutes12,
    SayAsInterpretAs_Time_HoursMinutesSeconds24,
    SayAsInterpretAs_Time_HoursMinutes24
  );
  {$EXTERNALSYM SayAsInterpretAs}

type
  PToggleState = ^ToggleState;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-togglestate</summary>
  ToggleState = (
    ToggleState_Off,
    ToggleState_On,
    ToggleState_Indeterminate
  );
  {$EXTERNALSYM ToggleState}

type
  PUIA_EVENT_ID = ^UIA_EVENT_ID;
  UIA_EVENT_ID = Integer;
  {$EXTERNALSYM UIA_EVENT_ID}
const
  // Constants for enum UIA_EVENT_ID
  UIA_ToolTipOpenedEventId = $4E20 { 20000 };
  {$EXTERNALSYM UIA_ToolTipOpenedEventId}
  UIA_ToolTipClosedEventId = $4E21 { 20001 };
  {$EXTERNALSYM UIA_ToolTipClosedEventId}
  UIA_StructureChangedEventId = $4E22 { 20002 };
  {$EXTERNALSYM UIA_StructureChangedEventId}
  UIA_MenuOpenedEventId = $4E23 { 20003 };
  {$EXTERNALSYM UIA_MenuOpenedEventId}
  UIA_AutomationPropertyChangedEventId = $4E24 { 20004 };
  {$EXTERNALSYM UIA_AutomationPropertyChangedEventId}
  UIA_AutomationFocusChangedEventId = $4E25 { 20005 };
  {$EXTERNALSYM UIA_AutomationFocusChangedEventId}
  UIA_AsyncContentLoadedEventId = $4E26 { 20006 };
  {$EXTERNALSYM UIA_AsyncContentLoadedEventId}
  UIA_MenuClosedEventId = $4E27 { 20007 };
  {$EXTERNALSYM UIA_MenuClosedEventId}
  UIA_LayoutInvalidatedEventId = $4E28 { 20008 };
  {$EXTERNALSYM UIA_LayoutInvalidatedEventId}
  UIA_Invoke_InvokedEventId = $4E29 { 20009 };
  {$EXTERNALSYM UIA_Invoke_InvokedEventId}
  UIA_SelectionItem_ElementAddedToSelectionEventId = $4E2A { 20010 };
  {$EXTERNALSYM UIA_SelectionItem_ElementAddedToSelectionEventId}
  UIA_SelectionItem_ElementRemovedFromSelectionEventId = $4E2B { 20011 };
  {$EXTERNALSYM UIA_SelectionItem_ElementRemovedFromSelectionEventId}
  UIA_SelectionItem_ElementSelectedEventId = $4E2C { 20012 };
  {$EXTERNALSYM UIA_SelectionItem_ElementSelectedEventId}
  UIA_Selection_InvalidatedEventId = $4E2D { 20013 };
  {$EXTERNALSYM UIA_Selection_InvalidatedEventId}
  UIA_Text_TextSelectionChangedEventId = $4E2E { 20014 };
  {$EXTERNALSYM UIA_Text_TextSelectionChangedEventId}
  UIA_Text_TextChangedEventId = $4E2F { 20015 };
  {$EXTERNALSYM UIA_Text_TextChangedEventId}
  UIA_Window_WindowOpenedEventId = $4E30 { 20016 };
  {$EXTERNALSYM UIA_Window_WindowOpenedEventId}
  UIA_Window_WindowClosedEventId = $4E31 { 20017 };
  {$EXTERNALSYM UIA_Window_WindowClosedEventId}
  UIA_MenuModeStartEventId = $4E32 { 20018 };
  {$EXTERNALSYM UIA_MenuModeStartEventId}
  UIA_MenuModeEndEventId = $4E33 { 20019 };
  {$EXTERNALSYM UIA_MenuModeEndEventId}
  UIA_InputReachedTargetEventId = $4E34 { 20020 };
  {$EXTERNALSYM UIA_InputReachedTargetEventId}
  UIA_InputReachedOtherElementEventId = $4E35 { 20021 };
  {$EXTERNALSYM UIA_InputReachedOtherElementEventId}
  UIA_InputDiscardedEventId = $4E36 { 20022 };
  {$EXTERNALSYM UIA_InputDiscardedEventId}
  UIA_SystemAlertEventId = $4E37 { 20023 };
  {$EXTERNALSYM UIA_SystemAlertEventId}
  UIA_LiveRegionChangedEventId = $4E38 { 20024 };
  {$EXTERNALSYM UIA_LiveRegionChangedEventId}
  UIA_HostedFragmentRootsInvalidatedEventId = $4E39 { 20025 };
  {$EXTERNALSYM UIA_HostedFragmentRootsInvalidatedEventId}
  UIA_Drag_DragStartEventId = $4E3A { 20026 };
  {$EXTERNALSYM UIA_Drag_DragStartEventId}
  UIA_Drag_DragCancelEventId = $4E3B { 20027 };
  {$EXTERNALSYM UIA_Drag_DragCancelEventId}
  UIA_Drag_DragCompleteEventId = $4E3C { 20028 };
  {$EXTERNALSYM UIA_Drag_DragCompleteEventId}
  UIA_DropTarget_DragEnterEventId = $4E3D { 20029 };
  {$EXTERNALSYM UIA_DropTarget_DragEnterEventId}
  UIA_DropTarget_DragLeaveEventId = $4E3E { 20030 };
  {$EXTERNALSYM UIA_DropTarget_DragLeaveEventId}
  UIA_DropTarget_DroppedEventId = $4E3F { 20031 };
  {$EXTERNALSYM UIA_DropTarget_DroppedEventId}
  UIA_TextEdit_TextChangedEventId = $4E40 { 20032 };
  {$EXTERNALSYM UIA_TextEdit_TextChangedEventId}
  UIA_TextEdit_ConversionTargetChangedEventId = $4E41 { 20033 };
  {$EXTERNALSYM UIA_TextEdit_ConversionTargetChangedEventId}
  UIA_ChangesEventId = $4E42 { 20034 };
  {$EXTERNALSYM UIA_ChangesEventId}
  UIA_NotificationEventId = $4E43 { 20035 };
  {$EXTERNALSYM UIA_NotificationEventId}
  UIA_ActiveTextPositionChangedEventId = $4E44 { 20036 };
  {$EXTERNALSYM UIA_ActiveTextPositionChangedEventId}

type
  PPropertyConditionFlags = ^PropertyConditionFlags;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-propertyconditionflags</summary>
  PropertyConditionFlags = (
    PropertyConditionFlags_None,
    PropertyConditionFlags_IgnoreCase,
    PropertyConditionFlags_MatchSubstring
  );
  {$EXTERNALSYM PropertyConditionFlags}

type
  PBulletStyle = ^BulletStyle;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-bulletstyle</summary>
  BulletStyle = Integer;
  {$EXTERNALSYM BulletStyle}
const
  // Constants for enum BulletStyle
  BulletStyle_Other = $FFFFFFFF { -1 };
  {$EXTERNALSYM BulletStyle_Other}
  BulletStyle_None = $0 { 0 };
  {$EXTERNALSYM BulletStyle_None}
  BulletStyle_HollowRoundBullet = $1 { 1 };
  {$EXTERNALSYM BulletStyle_HollowRoundBullet}
  BulletStyle_FilledRoundBullet = $2 { 2 };
  {$EXTERNALSYM BulletStyle_FilledRoundBullet}
  BulletStyle_HollowSquareBullet = $3 { 3 };
  {$EXTERNALSYM BulletStyle_HollowSquareBullet}
  BulletStyle_FilledSquareBullet = $4 { 4 };
  {$EXTERNALSYM BulletStyle_FilledSquareBullet}
  BulletStyle_DashBullet = $5 { 5 };
  {$EXTERNALSYM BulletStyle_DashBullet}

type
  PTextPatternRangeEndpoint = ^TextPatternRangeEndpoint;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-textpatternrangeendpoint</summary>
  TextPatternRangeEndpoint = (
    TextPatternRangeEndpoint_Start,
    TextPatternRangeEndpoint_End
  );
  {$EXTERNALSYM TextPatternRangeEndpoint}

type
  PAnnoScope = ^AnnoScope;
  AnnoScope = (
    ANNO_THIS,
    ANNO_CONTAINER
  );
  {$EXTERNALSYM AnnoScope}

type
  PSTICKYKEYS_FLAGS = ^STICKYKEYS_FLAGS;
  ///<remarks>This enumerated type is made up of bitwise flag values</remarks>
  STICKYKEYS_FLAGS = Cardinal;
  {$EXTERNALSYM STICKYKEYS_FLAGS}
const
  // Constants for enum STICKYKEYS_FLAGS
  SKF_STICKYKEYSON = $1 { 1 };
  {$EXTERNALSYM SKF_STICKYKEYSON}
  SKF_AVAILABLE = $2 { 2 };
  {$EXTERNALSYM SKF_AVAILABLE}
  SKF_HOTKEYACTIVE = $4 { 4 };
  {$EXTERNALSYM SKF_HOTKEYACTIVE}
  SKF_CONFIRMHOTKEY = $8 { 8 };
  {$EXTERNALSYM SKF_CONFIRMHOTKEY}
  SKF_HOTKEYSOUND = $10 { 16 };
  {$EXTERNALSYM SKF_HOTKEYSOUND}
  SKF_INDICATOR = $20 { 32 };
  {$EXTERNALSYM SKF_INDICATOR}
  SKF_AUDIBLEFEEDBACK = $40 { 64 };
  {$EXTERNALSYM SKF_AUDIBLEFEEDBACK}
  SKF_TRISTATE = $80 { 128 };
  {$EXTERNALSYM SKF_TRISTATE}
  SKF_TWOKEYSOFF = $100 { 256 };
  {$EXTERNALSYM SKF_TWOKEYSOFF}
  SKF_LALTLATCHED = $10000000 { 268435456 };
  {$EXTERNALSYM SKF_LALTLATCHED}
  SKF_LCTLLATCHED = $4000000 { 67108864 };
  {$EXTERNALSYM SKF_LCTLLATCHED}
  SKF_LSHIFTLATCHED = $1000000 { 16777216 };
  {$EXTERNALSYM SKF_LSHIFTLATCHED}
  SKF_RALTLATCHED = $20000000 { 536870912 };
  {$EXTERNALSYM SKF_RALTLATCHED}
  SKF_RCTLLATCHED = $8000000 { 134217728 };
  {$EXTERNALSYM SKF_RCTLLATCHED}
  SKF_RSHIFTLATCHED = $2000000 { 33554432 };
  {$EXTERNALSYM SKF_RSHIFTLATCHED}
  SKF_LWINLATCHED = $40000000 { 1073741824 };
  {$EXTERNALSYM SKF_LWINLATCHED}
  SKF_RWINLATCHED = $80000000 { -2147483648 };
  {$EXTERNALSYM SKF_RWINLATCHED}
  SKF_LALTLOCKED = $100000 { 1048576 };
  {$EXTERNALSYM SKF_LALTLOCKED}
  SKF_LCTLLOCKED = $40000 { 262144 };
  {$EXTERNALSYM SKF_LCTLLOCKED}
  SKF_LSHIFTLOCKED = $10000 { 65536 };
  {$EXTERNALSYM SKF_LSHIFTLOCKED}
  SKF_RALTLOCKED = $200000 { 2097152 };
  {$EXTERNALSYM SKF_RALTLOCKED}
  SKF_RCTLLOCKED = $80000 { 524288 };
  {$EXTERNALSYM SKF_RCTLLOCKED}
  SKF_RSHIFTLOCKED = $20000 { 131072 };
  {$EXTERNALSYM SKF_RSHIFTLOCKED}
  SKF_LWINLOCKED = $400000 { 4194304 };
  {$EXTERNALSYM SKF_LWINLOCKED}
  SKF_RWINLOCKED = $800000 { 8388608 };
  {$EXTERNALSYM SKF_RWINLOCKED}

type
  PVisualEffects = ^VisualEffects;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-visualeffects</summary>
  VisualEffects = Integer;
  {$EXTERNALSYM VisualEffects}
const
  // Constants for enum VisualEffects
  VisualEffects_None = $0 { 0 };
  {$EXTERNALSYM VisualEffects_None}
  VisualEffects_Shadow = $1 { 1 };
  {$EXTERNALSYM VisualEffects_Shadow}
  VisualEffects_Reflection = $2 { 2 };
  {$EXTERNALSYM VisualEffects_Reflection}
  VisualEffects_Glow = $4 { 4 };
  {$EXTERNALSYM VisualEffects_Glow}
  VisualEffects_SoftEdges = $8 { 8 };
  {$EXTERNALSYM VisualEffects_SoftEdges}
  VisualEffects_Bevel = $10 { 16 };
  {$EXTERNALSYM VisualEffects_Bevel}

type
  PUIA_STYLE_ID = ^UIA_STYLE_ID;
  UIA_STYLE_ID = Cardinal;
  {$EXTERNALSYM UIA_STYLE_ID}
const
  // Constants for enum UIA_STYLE_ID
  StyleId_Custom = $11170 { 70000 };
  {$EXTERNALSYM StyleId_Custom}
  StyleId_Heading1 = $11171 { 70001 };
  {$EXTERNALSYM StyleId_Heading1}
  StyleId_Heading2 = $11172 { 70002 };
  {$EXTERNALSYM StyleId_Heading2}
  StyleId_Heading3 = $11173 { 70003 };
  {$EXTERNALSYM StyleId_Heading3}
  StyleId_Heading4 = $11174 { 70004 };
  {$EXTERNALSYM StyleId_Heading4}
  StyleId_Heading5 = $11175 { 70005 };
  {$EXTERNALSYM StyleId_Heading5}
  StyleId_Heading6 = $11176 { 70006 };
  {$EXTERNALSYM StyleId_Heading6}
  StyleId_Heading7 = $11177 { 70007 };
  {$EXTERNALSYM StyleId_Heading7}
  StyleId_Heading8 = $11178 { 70008 };
  {$EXTERNALSYM StyleId_Heading8}
  StyleId_Heading9 = $11179 { 70009 };
  {$EXTERNALSYM StyleId_Heading9}
  StyleId_Title = $1117A { 70010 };
  {$EXTERNALSYM StyleId_Title}
  StyleId_Subtitle = $1117B { 70011 };
  {$EXTERNALSYM StyleId_Subtitle}
  StyleId_Normal = $1117C { 70012 };
  {$EXTERNALSYM StyleId_Normal}
  StyleId_Emphasis = $1117D { 70013 };
  {$EXTERNALSYM StyleId_Emphasis}
  StyleId_Quote = $1117E { 70014 };
  {$EXTERNALSYM StyleId_Quote}
  StyleId_BulletedList = $1117F { 70015 };
  {$EXTERNALSYM StyleId_BulletedList}
  StyleId_NumberedList = $11180 { 70016 };
  {$EXTERNALSYM StyleId_NumberedList}

type
  PHorizontalTextAlignment = ^HorizontalTextAlignment;
  HorizontalTextAlignment = (
    HorizontalTextAlignment_Left,
    HorizontalTextAlignment_Centered,
    HorizontalTextAlignment_Right,
    HorizontalTextAlignment_Justified
  );
  {$EXTERNALSYM HorizontalTextAlignment}

type
  PTextEditChangeType = ^TextEditChangeType;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-texteditchangetype</summary>
  TextEditChangeType = (
    TextEditChangeType_None,
    TextEditChangeType_AutoCorrect,
    TextEditChangeType_Composition,
    TextEditChangeType_CompositionFinalized,
    TextEditChangeType_AutoComplete
  );
  {$EXTERNALSYM TextEditChangeType}

type
  PProviderOptions = ^ProviderOptions;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-provideroptions</summary>
  ///<remarks>This enumerated type is made up of bitwise flag values</remarks>
  ProviderOptions = Integer;
  {$EXTERNALSYM ProviderOptions}
const
  // Constants for enum ProviderOptions
  ProviderOptions_ClientSideProvider = $1 { 1 };
  {$EXTERNALSYM ProviderOptions_ClientSideProvider}
  ProviderOptions_ServerSideProvider = $2 { 2 };
  {$EXTERNALSYM ProviderOptions_ServerSideProvider}
  ProviderOptions_NonClientAreaProvider = $4 { 4 };
  {$EXTERNALSYM ProviderOptions_NonClientAreaProvider}
  ProviderOptions_OverrideProvider = $8 { 8 };
  {$EXTERNALSYM ProviderOptions_OverrideProvider}
  ProviderOptions_ProviderOwnsSetFocus = $10 { 16 };
  {$EXTERNALSYM ProviderOptions_ProviderOwnsSetFocus}
  ProviderOptions_UseComThreading = $20 { 32 };
  {$EXTERNALSYM ProviderOptions_UseComThreading}
  ProviderOptions_RefuseNonClientSupport = $40 { 64 };
  {$EXTERNALSYM ProviderOptions_RefuseNonClientSupport}
  ProviderOptions_HasNativeIAccessible = $80 { 128 };
  {$EXTERNALSYM ProviderOptions_HasNativeIAccessible}
  ProviderOptions_UseClientCoordinates = $100 { 256 };
  {$EXTERNALSYM ProviderOptions_UseClientCoordinates}

type
  PUIA_CHANGE_ID = ^UIA_CHANGE_ID;
  UIA_CHANGE_ID = Cardinal;
  {$EXTERNALSYM UIA_CHANGE_ID}
const
  // Constants for enum UIA_CHANGE_ID
  UIA_SummaryChangeId = $15F90 { 90000 };
  {$EXTERNALSYM UIA_SummaryChangeId}

type
  PUIA_LANDMARKTYPE_ID = ^UIA_LANDMARKTYPE_ID;
  UIA_LANDMARKTYPE_ID = Cardinal;
  {$EXTERNALSYM UIA_LANDMARKTYPE_ID}
const
  // Constants for enum UIA_LANDMARKTYPE_ID
  UIA_CustomLandmarkTypeId = $13880 { 80000 };
  {$EXTERNALSYM UIA_CustomLandmarkTypeId}
  UIA_FormLandmarkTypeId = $13881 { 80001 };
  {$EXTERNALSYM UIA_FormLandmarkTypeId}
  UIA_MainLandmarkTypeId = $13882 { 80002 };
  {$EXTERNALSYM UIA_MainLandmarkTypeId}
  UIA_NavigationLandmarkTypeId = $13883 { 80003 };
  {$EXTERNALSYM UIA_NavigationLandmarkTypeId}
  UIA_SearchLandmarkTypeId = $13884 { 80004 };
  {$EXTERNALSYM UIA_SearchLandmarkTypeId}

type
  PSynchronizedInputType = ^SynchronizedInputType;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-synchronizedinputtype</summary>
  ///<remarks>This enumerated type is made up of bitwise flag values</remarks>
  SynchronizedInputType = Integer;
  {$EXTERNALSYM SynchronizedInputType}
const
  // Constants for enum SynchronizedInputType
  SynchronizedInputType_KeyUp = $1 { 1 };
  {$EXTERNALSYM SynchronizedInputType_KeyUp}
  SynchronizedInputType_KeyDown = $2 { 2 };
  {$EXTERNALSYM SynchronizedInputType_KeyDown}
  SynchronizedInputType_LeftMouseUp = $4 { 4 };
  {$EXTERNALSYM SynchronizedInputType_LeftMouseUp}
  SynchronizedInputType_LeftMouseDown = $8 { 8 };
  {$EXTERNALSYM SynchronizedInputType_LeftMouseDown}
  SynchronizedInputType_RightMouseUp = $10 { 16 };
  {$EXTERNALSYM SynchronizedInputType_RightMouseUp}
  SynchronizedInputType_RightMouseDown = $20 { 32 };
  {$EXTERNALSYM SynchronizedInputType_RightMouseDown}

type
  PUIA_CONTROLTYPE_ID = ^UIA_CONTROLTYPE_ID;
  UIA_CONTROLTYPE_ID = Cardinal;
  {$EXTERNALSYM UIA_CONTROLTYPE_ID}
const
  // Constants for enum UIA_CONTROLTYPE_ID
  UIA_ButtonControlTypeId = $C350 { 50000 };
  {$EXTERNALSYM UIA_ButtonControlTypeId}
  UIA_CalendarControlTypeId = $C351 { 50001 };
  {$EXTERNALSYM UIA_CalendarControlTypeId}
  UIA_CheckBoxControlTypeId = $C352 { 50002 };
  {$EXTERNALSYM UIA_CheckBoxControlTypeId}
  UIA_ComboBoxControlTypeId = $C353 { 50003 };
  {$EXTERNALSYM UIA_ComboBoxControlTypeId}
  UIA_EditControlTypeId = $C354 { 50004 };
  {$EXTERNALSYM UIA_EditControlTypeId}
  UIA_HyperlinkControlTypeId = $C355 { 50005 };
  {$EXTERNALSYM UIA_HyperlinkControlTypeId}
  UIA_ImageControlTypeId = $C356 { 50006 };
  {$EXTERNALSYM UIA_ImageControlTypeId}
  UIA_ListItemControlTypeId = $C357 { 50007 };
  {$EXTERNALSYM UIA_ListItemControlTypeId}
  UIA_ListControlTypeId = $C358 { 50008 };
  {$EXTERNALSYM UIA_ListControlTypeId}
  UIA_MenuControlTypeId = $C359 { 50009 };
  {$EXTERNALSYM UIA_MenuControlTypeId}
  UIA_MenuBarControlTypeId = $C35A { 50010 };
  {$EXTERNALSYM UIA_MenuBarControlTypeId}
  UIA_MenuItemControlTypeId = $C35B { 50011 };
  {$EXTERNALSYM UIA_MenuItemControlTypeId}
  UIA_ProgressBarControlTypeId = $C35C { 50012 };
  {$EXTERNALSYM UIA_ProgressBarControlTypeId}
  UIA_RadioButtonControlTypeId = $C35D { 50013 };
  {$EXTERNALSYM UIA_RadioButtonControlTypeId}
  UIA_ScrollBarControlTypeId = $C35E { 50014 };
  {$EXTERNALSYM UIA_ScrollBarControlTypeId}
  UIA_SliderControlTypeId = $C35F { 50015 };
  {$EXTERNALSYM UIA_SliderControlTypeId}
  UIA_SpinnerControlTypeId = $C360 { 50016 };
  {$EXTERNALSYM UIA_SpinnerControlTypeId}
  UIA_StatusBarControlTypeId = $C361 { 50017 };
  {$EXTERNALSYM UIA_StatusBarControlTypeId}
  UIA_TabControlTypeId = $C362 { 50018 };
  {$EXTERNALSYM UIA_TabControlTypeId}
  UIA_TabItemControlTypeId = $C363 { 50019 };
  {$EXTERNALSYM UIA_TabItemControlTypeId}
  UIA_TextControlTypeId = $C364 { 50020 };
  {$EXTERNALSYM UIA_TextControlTypeId}
  UIA_ToolBarControlTypeId = $C365 { 50021 };
  {$EXTERNALSYM UIA_ToolBarControlTypeId}
  UIA_ToolTipControlTypeId = $C366 { 50022 };
  {$EXTERNALSYM UIA_ToolTipControlTypeId}
  UIA_TreeControlTypeId = $C367 { 50023 };
  {$EXTERNALSYM UIA_TreeControlTypeId}
  UIA_TreeItemControlTypeId = $C368 { 50024 };
  {$EXTERNALSYM UIA_TreeItemControlTypeId}
  UIA_CustomControlTypeId = $C369 { 50025 };
  {$EXTERNALSYM UIA_CustomControlTypeId}
  UIA_GroupControlTypeId = $C36A { 50026 };
  {$EXTERNALSYM UIA_GroupControlTypeId}
  UIA_ThumbControlTypeId = $C36B { 50027 };
  {$EXTERNALSYM UIA_ThumbControlTypeId}
  UIA_DataGridControlTypeId = $C36C { 50028 };
  {$EXTERNALSYM UIA_DataGridControlTypeId}
  UIA_DataItemControlTypeId = $C36D { 50029 };
  {$EXTERNALSYM UIA_DataItemControlTypeId}
  UIA_DocumentControlTypeId = $C36E { 50030 };
  {$EXTERNALSYM UIA_DocumentControlTypeId}
  UIA_SplitButtonControlTypeId = $C36F { 50031 };
  {$EXTERNALSYM UIA_SplitButtonControlTypeId}
  UIA_WindowControlTypeId = $C370 { 50032 };
  {$EXTERNALSYM UIA_WindowControlTypeId}
  UIA_PaneControlTypeId = $C371 { 50033 };
  {$EXTERNALSYM UIA_PaneControlTypeId}
  UIA_HeaderControlTypeId = $C372 { 50034 };
  {$EXTERNALSYM UIA_HeaderControlTypeId}
  UIA_HeaderItemControlTypeId = $C373 { 50035 };
  {$EXTERNALSYM UIA_HeaderItemControlTypeId}
  UIA_TableControlTypeId = $C374 { 50036 };
  {$EXTERNALSYM UIA_TableControlTypeId}
  UIA_TitleBarControlTypeId = $C375 { 50037 };
  {$EXTERNALSYM UIA_TitleBarControlTypeId}
  UIA_SeparatorControlTypeId = $C376 { 50038 };
  {$EXTERNALSYM UIA_SeparatorControlTypeId}
  UIA_SemanticZoomControlTypeId = $C377 { 50039 };
  {$EXTERNALSYM UIA_SemanticZoomControlTypeId}
  UIA_AppBarControlTypeId = $C378 { 50040 };
  {$EXTERNALSYM UIA_AppBarControlTypeId}

type
  PFillType = ^FillType;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-filltype</summary>
  FillType = (
    FillType_None,
    FillType_Color,
    FillType_Gradient,
    FillType_Picture,
    FillType_Pattern
  );
  {$EXTERNALSYM FillType}

type
  POutlineStyles = ^OutlineStyles;
  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-outlinestyles</summary>
  OutlineStyles = Integer;
  {$EXTERNALSYM OutlineStyles}
const
  // Constants for enum OutlineStyles
  OutlineStyles_None = $0 { 0 };
  {$EXTERNALSYM OutlineStyles_None}
  OutlineStyles_Outline = $1 { 1 };
  {$EXTERNALSYM OutlineStyles_Outline}
  OutlineStyles_Shadow = $2 { 2 };
  {$EXTERNALSYM OutlineStyles_Shadow}
  OutlineStyles_Engraved = $4 { 4 };
  {$EXTERNALSYM OutlineStyles_Engraved}
  OutlineStyles_Embossed = $8 { 8 };
  {$EXTERNALSYM OutlineStyles_Embossed}

type
  // Forward declarations for interfaces

  // Windows  UI Automation.IUIAutomationCondition
  IUIAutomationCondition = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationCondition)'}
  PIUIAutomationCondition = ^IUIAutomationCondition;

  // Windows  UI Automation.IUIAutomationElementArray
  IUIAutomationElementArray = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationElementArray)'}
  PIUIAutomationElementArray = ^IUIAutomationElementArray;

  // Windows  UI Automation.IUIAutomationCacheRequest
  IUIAutomationCacheRequest = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationCacheRequest)'}
  PIUIAutomationCacheRequest = ^IUIAutomationCacheRequest;

  // Windows  UI Automation.IUIAutomationElement
  IUIAutomationElement = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationElement)'}
  PIUIAutomationElement = ^IUIAutomationElement;

  // Windows  UI Automation.IUIAutomationTreeWalker
  IUIAutomationTreeWalker = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTreeWalker)'}
  PIUIAutomationTreeWalker = ^IUIAutomationTreeWalker;

  // Windows  UI Automation.IUIAutomationEventHandler
  IUIAutomationEventHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationEventHandler)'}
  PIUIAutomationEventHandler = ^IUIAutomationEventHandler;

  // Windows  UI Automation.IUIAutomationPropertyChangedEventHandler
  IUIAutomationPropertyChangedEventHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationPropertyChangedEventHandler)'}
  PIUIAutomationPropertyChangedEventHandler = ^IUIAutomationPropertyChangedEventHandler;

  // Windows  UI Automation.IUIAutomationStructureChangedEventHandler
  IUIAutomationStructureChangedEventHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationStructureChangedEventHandler)'}
  PIUIAutomationStructureChangedEventHandler = ^IUIAutomationStructureChangedEventHandler;

  // Windows  UI Automation.IUIAutomationFocusChangedEventHandler
  IUIAutomationFocusChangedEventHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationFocusChangedEventHandler)'}
  PIUIAutomationFocusChangedEventHandler = ^IUIAutomationFocusChangedEventHandler;

  // Windows  UI Automation.IRawElementProviderSimple
  IRawElementProviderSimple = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRawElementProviderSimple)'}
  PIRawElementProviderSimple = ^IRawElementProviderSimple;

  // Windows  UI Automation.IUIAutomationProxyFactory
  IUIAutomationProxyFactory = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationProxyFactory)'}
  PIUIAutomationProxyFactory = ^IUIAutomationProxyFactory;

  // Windows  UI Automation.IUIAutomationProxyFactoryEntry
  IUIAutomationProxyFactoryEntry = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationProxyFactoryEntry)'}
  PIUIAutomationProxyFactoryEntry = ^IUIAutomationProxyFactoryEntry;

  // Windows  UI Automation.IUIAutomationProxyFactoryMapping
  IUIAutomationProxyFactoryMapping = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationProxyFactoryMapping)'}
  PIUIAutomationProxyFactoryMapping = ^IUIAutomationProxyFactoryMapping;

  // Windows  UI Automation.IAccessible
  IAccessible = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IAccessible)'}
  PIAccessible = ^IAccessible;

  // Windows  UI Automation.IUIAutomation
  IUIAutomation = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomation)'}
  PIUIAutomation = ^IUIAutomation;

  // Windows  UI Automation.IUIAutomationTextRange
  IUIAutomationTextRange = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTextRange)'}
  PIUIAutomationTextRange = ^IUIAutomationTextRange;

  // Windows  UI Automation.IAccessibleEx
  IAccessibleEx = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IAccessibleEx)'}
  PIAccessibleEx = ^IAccessibleEx;

  // Windows  UI Automation.IUIAutomationElement2
  IUIAutomationElement2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationElement2)'}
  PIUIAutomationElement2 = ^IUIAutomationElement2;

  // Windows  UI Automation.IUIAutomationElement3
  IUIAutomationElement3 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationElement3)'}
  PIUIAutomationElement3 = ^IUIAutomationElement3;

  // Windows  UI Automation.IUIAutomationElement4
  IUIAutomationElement4 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationElement4)'}
  PIUIAutomationElement4 = ^IUIAutomationElement4;

  // Windows  UI Automation.IUIAutomationElement5
  IUIAutomationElement5 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationElement5)'}
  PIUIAutomationElement5 = ^IUIAutomationElement5;

  // Windows  UI Automation.ITextRangeProvider
  ITextRangeProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITextRangeProvider)'}
  PITextRangeProvider = ^ITextRangeProvider;

  // Windows  UI Automation.ITextProvider
  ITextProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITextProvider)'}
  PITextProvider = ^ITextProvider;

  // Windows  UI Automation.ITextProvider2
  ITextProvider2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITextProvider2)'}
  PITextProvider2 = ^ITextProvider2;

  // Windows  UI Automation.IUIAutomationItemContainerPattern
  IUIAutomationItemContainerPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationItemContainerPattern)'}
  PIUIAutomationItemContainerPattern = ^IUIAutomationItemContainerPattern;

  // Windows  UI Automation.ITransformProvider
  ITransformProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITransformProvider)'}
  PITransformProvider = ^ITransformProvider;

  // Windows  UI Automation.ITransformProvider2
  ITransformProvider2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITransformProvider2)'}
  PITransformProvider2 = ^ITransformProvider2;

  // Windows  UI Automation.IUIAutomationDragPattern
  IUIAutomationDragPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationDragPattern)'}
  PIUIAutomationDragPattern = ^IUIAutomationDragPattern;

  // Windows  UI Automation.IExpandCollapseProvider
  IExpandCollapseProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IExpandCollapseProvider)'}
  PIExpandCollapseProvider = ^IExpandCollapseProvider;

  // Windows  UI Automation.IUIAutomationNotificationEventHandler
  IUIAutomationNotificationEventHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationNotificationEventHandler)'}
  PIUIAutomationNotificationEventHandler = ^IUIAutomationNotificationEventHandler;

  // Windows  UI Automation.IUIAutomationPatternInstance
  IUIAutomationPatternInstance = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationPatternInstance)'}
  PIUIAutomationPatternInstance = ^IUIAutomationPatternInstance;

  // Windows  UI Automation.IUIAutomationScrollPattern
  IUIAutomationScrollPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationScrollPattern)'}
  PIUIAutomationScrollPattern = ^IUIAutomationScrollPattern;

  // Windows  UI Automation.IRawElementProviderHostingAccessibles
  IRawElementProviderHostingAccessibles = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRawElementProviderHostingAccessibles)'}
  PIRawElementProviderHostingAccessibles = ^IRawElementProviderHostingAccessibles;

  // Windows  UI Automation.IUIAutomationElement6
  IUIAutomationElement6 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationElement6)'}
  PIUIAutomationElement6 = ^IUIAutomationElement6;

  // Windows  UI Automation.IUIAutomationElement7
  IUIAutomationElement7 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationElement7)'}
  PIUIAutomationElement7 = ^IUIAutomationElement7;

  // Windows  UI Automation.IUIAutomationElement8
  IUIAutomationElement8 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationElement8)'}
  PIUIAutomationElement8 = ^IUIAutomationElement8;

  // Windows  UI Automation.IUIAutomationElement9
  IUIAutomationElement9 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationElement9)'}
  PIUIAutomationElement9 = ^IUIAutomationElement9;

  // Windows  UI Automation.IToggleProvider
  IToggleProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IToggleProvider)'}
  PIToggleProvider = ^IToggleProvider;

  // Windows  UI Automation.IUIAutomationTextRange2
  IUIAutomationTextRange2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTextRange2)'}
  PIUIAutomationTextRange2 = ^IUIAutomationTextRange2;

  // Windows  UI Automation.IUIAutomationTextRangeArray
  IUIAutomationTextRangeArray = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTextRangeArray)'}
  PIUIAutomationTextRangeArray = ^IUIAutomationTextRangeArray;

  // Windows  UI Automation.IUIAutomation2
  IUIAutomation2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomation2)'}
  PIUIAutomation2 = ^IUIAutomation2;

  // Windows  UI Automation.IUIAutomationTextEditTextChangedEventHandler
  IUIAutomationTextEditTextChangedEventHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTextEditTextChangedEventHandler)'}
  PIUIAutomationTextEditTextChangedEventHandler = ^IUIAutomationTextEditTextChangedEventHandler;

  // Windows  UI Automation.IUIAutomation3
  IUIAutomation3 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomation3)'}
  PIUIAutomation3 = ^IUIAutomation3;

  // Windows  UI Automation.IUIAutomationChangesEventHandler
  IUIAutomationChangesEventHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationChangesEventHandler)'}
  PIUIAutomationChangesEventHandler = ^IUIAutomationChangesEventHandler;

  // Windows  UI Automation.IUIAutomation4
  IUIAutomation4 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomation4)'}
  PIUIAutomation4 = ^IUIAutomation4;

  // Windows  UI Automation.IUIAutomation5
  IUIAutomation5 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomation5)'}
  PIUIAutomation5 = ^IUIAutomation5;

  // Windows  UI Automation.IUIAutomationTextPattern
  IUIAutomationTextPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTextPattern)'}
  PIUIAutomationTextPattern = ^IUIAutomationTextPattern;

  // Windows  UI Automation.IUIAutomationTransformPattern
  IUIAutomationTransformPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTransformPattern)'}
  PIUIAutomationTransformPattern = ^IUIAutomationTransformPattern;

  // Windows  UI Automation.IUIAutomationTextPattern2
  IUIAutomationTextPattern2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTextPattern2)'}
  PIUIAutomationTextPattern2 = ^IUIAutomationTextPattern2;

  // Windows  UI Automation.IValueProvider
  IValueProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IValueProvider)'}
  PIValueProvider = ^IValueProvider;

  // Windows  UI Automation.IUIAutomationActiveTextPositionChangedEventHandler
  IUIAutomationActiveTextPositionChangedEventHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationActiveTextPositionChangedEventHandler)'}
  PIUIAutomationActiveTextPositionChangedEventHandler = ^IUIAutomationActiveTextPositionChangedEventHandler;

  // Windows  UI Automation.IUIAutomationEventHandlerGroup
  IUIAutomationEventHandlerGroup = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationEventHandlerGroup)'}
  PIUIAutomationEventHandlerGroup = ^IUIAutomationEventHandlerGroup;

  // Windows  UI Automation.IUIAutomationMultipleViewPattern
  IUIAutomationMultipleViewPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationMultipleViewPattern)'}
  PIUIAutomationMultipleViewPattern = ^IUIAutomationMultipleViewPattern;

  // Windows  UI Automation.IUIAutomationScrollItemPattern
  IUIAutomationScrollItemPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationScrollItemPattern)'}
  PIUIAutomationScrollItemPattern = ^IUIAutomationScrollItemPattern;

  // Windows  UI Automation.IMultipleViewProvider
  IMultipleViewProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMultipleViewProvider)'}
  PIMultipleViewProvider = ^IMultipleViewProvider;

  // Windows  UI Automation.IWindowProvider
  IWindowProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IWindowProvider)'}
  PIWindowProvider = ^IWindowProvider;

  // Windows  UI Automation.IRawElementProviderFragmentRoot
  IRawElementProviderFragmentRoot = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRawElementProviderFragmentRoot)'}
  PIRawElementProviderFragmentRoot = ^IRawElementProviderFragmentRoot;

  // Windows  UI Automation.IRawElementProviderFragment
  IRawElementProviderFragment = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRawElementProviderFragment)'}
  PIRawElementProviderFragment = ^IRawElementProviderFragment;

  // Windows  UI Automation.IRangeValueProvider
  IRangeValueProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRangeValueProvider)'}
  PIRangeValueProvider = ^IRangeValueProvider;

  // Windows  UI Automation.IItemContainerProvider
  IItemContainerProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IItemContainerProvider)'}
  PIItemContainerProvider = ^IItemContainerProvider;

  // Windows  UI Automation.IStylesProvider
  IStylesProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IStylesProvider)'}
  PIStylesProvider = ^IStylesProvider;

  // Windows  UI Automation.IInvokeProvider
  IInvokeProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IInvokeProvider)'}
  PIInvokeProvider = ^IInvokeProvider;

  // Windows  UI Automation.IUIAutomationExpandCollapsePattern
  IUIAutomationExpandCollapsePattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationExpandCollapsePattern)'}
  PIUIAutomationExpandCollapsePattern = ^IUIAutomationExpandCollapsePattern;

  // Windows  UI Automation.IRawElementProviderWindowlessSite
  IRawElementProviderWindowlessSite = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRawElementProviderWindowlessSite)'}
  PIRawElementProviderWindowlessSite = ^IRawElementProviderWindowlessSite;

  // Windows  UI Automation.IRicheditWindowlessAccessibility
  IRicheditWindowlessAccessibility = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRicheditWindowlessAccessibility)'}
  PIRicheditWindowlessAccessibility = ^IRicheditWindowlessAccessibility;

  // Windows  UI Automation.IVirtualizedItemProvider
  IVirtualizedItemProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IVirtualizedItemProvider)'}
  PIVirtualizedItemProvider = ^IVirtualizedItemProvider;

  // Windows  UI Automation.ISelectionProvider
  ISelectionProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISelectionProvider)'}
  PISelectionProvider = ^ISelectionProvider;

  // Windows  UI Automation.ISelectionProvider2
  ISelectionProvider2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISelectionProvider2)'}
  PISelectionProvider2 = ^ISelectionProvider2;

  // Windows  UI Automation.IAccessibleHostingElementProviders
  IAccessibleHostingElementProviders = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IAccessibleHostingElementProviders)'}
  PIAccessibleHostingElementProviders = ^IAccessibleHostingElementProviders;

  // Windows  UI Automation.IDockProvider
  IDockProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDockProvider)'}
  PIDockProvider = ^IDockProvider;

  // Windows  UI Automation.IUIAutomationSelectionItemPattern
  IUIAutomationSelectionItemPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationSelectionItemPattern)'}
  PIUIAutomationSelectionItemPattern = ^IUIAutomationSelectionItemPattern;

  // Windows  UI Automation.IRawElementProviderSimple2
  IRawElementProviderSimple2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRawElementProviderSimple2)'}
  PIRawElementProviderSimple2 = ^IRawElementProviderSimple2;

  // Windows  UI Automation.IRawElementProviderSimple3
  IRawElementProviderSimple3 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRawElementProviderSimple3)'}
  PIRawElementProviderSimple3 = ^IRawElementProviderSimple3;

  // Windows  UI Automation.IScrollItemProvider
  IScrollItemProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IScrollItemProvider)'}
  PIScrollItemProvider = ^IScrollItemProvider;

  // Windows  UI Automation.ISynchronizedInputProvider
  ISynchronizedInputProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISynchronizedInputProvider)'}
  PISynchronizedInputProvider = ^ISynchronizedInputProvider;

  // Windows  UI Automation.IUIAutomationCustomNavigationPattern
  IUIAutomationCustomNavigationPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationCustomNavigationPattern)'}
  PIUIAutomationCustomNavigationPattern = ^IUIAutomationCustomNavigationPattern;

  // Windows  UI Automation.IUIAutomationBoolCondition
  IUIAutomationBoolCondition = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationBoolCondition)'}
  PIUIAutomationBoolCondition = ^IUIAutomationBoolCondition;

  // Windows  UI Automation.IRawElementProviderAdviseEvents
  IRawElementProviderAdviseEvents = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRawElementProviderAdviseEvents)'}
  PIRawElementProviderAdviseEvents = ^IRawElementProviderAdviseEvents;

  // Windows  UI Automation.IRawElementProviderHwndOverride
  IRawElementProviderHwndOverride = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRawElementProviderHwndOverride)'}
  PIRawElementProviderHwndOverride = ^IRawElementProviderHwndOverride;

  // Windows  UI Automation.ITableProvider
  ITableProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITableProvider)'}
  PITableProvider = ^ITableProvider;

  // Windows  UI Automation.ISpreadsheetItemProvider
  ISpreadsheetItemProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISpreadsheetItemProvider)'}
  PISpreadsheetItemProvider = ^ISpreadsheetItemProvider;

  // Windows  UI Automation.IProxyProviderWinEventSink
  IProxyProviderWinEventSink = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IProxyProviderWinEventSink)'}
  PIProxyProviderWinEventSink = ^IProxyProviderWinEventSink;

  // Windows  UI Automation.IObjectModelProvider
  IObjectModelProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IObjectModelProvider)'}
  PIObjectModelProvider = ^IObjectModelProvider;

  // Windows  UI Automation.IUIAutomationOrCondition
  IUIAutomationOrCondition = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationOrCondition)'}
  PIUIAutomationOrCondition = ^IUIAutomationOrCondition;

  // Windows  UI Automation.IUIAutomationValuePattern
  IUIAutomationValuePattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationValuePattern)'}
  PIUIAutomationValuePattern = ^IUIAutomationValuePattern;

  // Windows  UI Automation.ICustomNavigationProvider
  ICustomNavigationProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ICustomNavigationProvider)'}
  PICustomNavigationProvider = ^ICustomNavigationProvider;

  // Windows  UI Automation.IGridProvider
  IGridProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IGridProvider)'}
  PIGridProvider = ^IGridProvider;

  // Windows  UI Automation.IUIAutomationTextEditPattern
  IUIAutomationTextEditPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTextEditPattern)'}
  PIUIAutomationTextEditPattern = ^IUIAutomationTextEditPattern;

  // Windows  UI Automation.IUIAutomationAnnotationPattern
  IUIAutomationAnnotationPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationAnnotationPattern)'}
  PIUIAutomationAnnotationPattern = ^IUIAutomationAnnotationPattern;

  // Windows  UI Automation.IUIAutomationAndCondition
  IUIAutomationAndCondition = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationAndCondition)'}
  PIUIAutomationAndCondition = ^IUIAutomationAndCondition;

  // Windows  UI Automation.IUIAutomationTablePattern
  IUIAutomationTablePattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTablePattern)'}
  PIUIAutomationTablePattern = ^IUIAutomationTablePattern;

  // Windows  UI Automation.IUIAutomationStylesPattern
  IUIAutomationStylesPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationStylesPattern)'}
  PIUIAutomationStylesPattern = ^IUIAutomationStylesPattern;

  // Windows  UI Automation.IUIAutomationGridItemPattern
  IUIAutomationGridItemPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationGridItemPattern)'}
  PIUIAutomationGridItemPattern = ^IUIAutomationGridItemPattern;

  // Windows  UI Automation.IAnnotationProvider
  IAnnotationProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IAnnotationProvider)'}
  PIAnnotationProvider = ^IAnnotationProvider;

  // Windows  UI Automation.IUIAutomationSpreadsheetItemPattern
  IUIAutomationSpreadsheetItemPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationSpreadsheetItemPattern)'}
  PIUIAutomationSpreadsheetItemPattern = ^IUIAutomationSpreadsheetItemPattern;

  // Windows  UI Automation.IRichEditUiaInformation
  IRichEditUiaInformation = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRichEditUiaInformation)'}
  PIRichEditUiaInformation = ^IRichEditUiaInformation;

  // Windows  UI Automation.IProxyProviderWinEventHandler
  IProxyProviderWinEventHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IProxyProviderWinEventHandler)'}
  PIProxyProviderWinEventHandler = ^IProxyProviderWinEventHandler;

  // Windows  UI Automation.IAccPropServer
  IAccPropServer = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IAccPropServer)'}
  PIAccPropServer = ^IAccPropServer;

  // Windows  UI Automation.IUIAutomationTextRange3
  IUIAutomationTextRange3 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTextRange3)'}
  PIUIAutomationTextRange3 = ^IUIAutomationTextRange3;

  // Windows  UI Automation.IUIAutomationSelectionPattern
  IUIAutomationSelectionPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationSelectionPattern)'}
  PIUIAutomationSelectionPattern = ^IUIAutomationSelectionPattern;

  // Windows  UI Automation.IUIAutomationSelectionPattern2
  IUIAutomationSelectionPattern2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationSelectionPattern2)'}
  PIUIAutomationSelectionPattern2 = ^IUIAutomationSelectionPattern2;

  // Windows  UI Automation.IUIAutomationSynchronizedInputPattern
  IUIAutomationSynchronizedInputPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationSynchronizedInputPattern)'}
  PIUIAutomationSynchronizedInputPattern = ^IUIAutomationSynchronizedInputPattern;

  // Windows  UI Automation.ITextRangeProvider2
  ITextRangeProvider2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITextRangeProvider2)'}
  PITextRangeProvider2 = ^ITextRangeProvider2;

  // Windows  UI Automation.IUIAutomation6
  IUIAutomation6 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomation6)'}
  PIUIAutomation6 = ^IUIAutomation6;

  // Windows  UI Automation.ITableItemProvider
  ITableItemProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITableItemProvider)'}
  PITableItemProvider = ^ITableItemProvider;

  // Windows  UI Automation.IAccessibleHandler
  IAccessibleHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IAccessibleHandler)'}
  PIAccessibleHandler = ^IAccessibleHandler;

  // Windows  UI Automation.IAccessibleWindowlessSite
  IAccessibleWindowlessSite = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IAccessibleWindowlessSite)'}
  PIAccessibleWindowlessSite = ^IAccessibleWindowlessSite;

  // Windows  UI Automation.ILegacyIAccessibleProvider
  ILegacyIAccessibleProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ILegacyIAccessibleProvider)'}
  PILegacyIAccessibleProvider = ^ILegacyIAccessibleProvider;

  // Windows  UI Automation.IAccIdentity
  IAccIdentity = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IAccIdentity)'}
  PIAccIdentity = ^IAccIdentity;

  // Windows  UI Automation.IUIAutomationInvokePattern
  IUIAutomationInvokePattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationInvokePattern)'}
  PIUIAutomationInvokePattern = ^IUIAutomationInvokePattern;

  // Windows  UI Automation.IUIAutomationGridPattern
  IUIAutomationGridPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationGridPattern)'}
  PIUIAutomationGridPattern = ^IUIAutomationGridPattern;

  // Windows  UI Automation.IScrollProvider
  IScrollProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IScrollProvider)'}
  PIScrollProvider = ^IScrollProvider;

  // Windows  UI Automation.IUIAutomationTableItemPattern
  IUIAutomationTableItemPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTableItemPattern)'}
  PIUIAutomationTableItemPattern = ^IUIAutomationTableItemPattern;

  // Windows  UI Automation.IUIAutomationWindowPattern
  IUIAutomationWindowPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationWindowPattern)'}
  PIUIAutomationWindowPattern = ^IUIAutomationWindowPattern;

  // Windows  UI Automation.IDragProvider
  IDragProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDragProvider)'}
  PIDragProvider = ^IDragProvider;

  // Windows  UI Automation.IUIAutomationPropertyCondition
  IUIAutomationPropertyCondition = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationPropertyCondition)'}
  PIUIAutomationPropertyCondition = ^IUIAutomationPropertyCondition;

  // Windows  UI Automation.IUIAutomationTogglePattern
  IUIAutomationTogglePattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTogglePattern)'}
  PIUIAutomationTogglePattern = ^IUIAutomationTogglePattern;

  // Windows  UI Automation.IAccPropServices
  IAccPropServices = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IAccPropServices)'}
  PIAccPropServices = ^IAccPropServices;

  // Windows  UI Automation.IDropTargetProvider
  IDropTargetProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDropTargetProvider)'}
  PIDropTargetProvider = ^IDropTargetProvider;

  // Windows  UI Automation.IUIAutomationDropTargetPattern
  IUIAutomationDropTargetPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationDropTargetPattern)'}
  PIUIAutomationDropTargetPattern = ^IUIAutomationDropTargetPattern;

  // Windows  UI Automation.ITextEditProvider
  ITextEditProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITextEditProvider)'}
  PITextEditProvider = ^ITextEditProvider;

  // Windows  UI Automation.ISelectionItemProvider
  ISelectionItemProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISelectionItemProvider)'}
  PISelectionItemProvider = ^ISelectionItemProvider;

  // Windows  UI Automation.ITextChildProvider
  ITextChildProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITextChildProvider)'}
  PITextChildProvider = ^ITextChildProvider;

  // Windows  UI Automation.IUIAutomationDockPattern
  IUIAutomationDockPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationDockPattern)'}
  PIUIAutomationDockPattern = ^IUIAutomationDockPattern;

  // Windows  UI Automation.IUIAutomationObjectModelPattern
  IUIAutomationObjectModelPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationObjectModelPattern)'}
  PIUIAutomationObjectModelPattern = ^IUIAutomationObjectModelPattern;

  // Windows  UI Automation.IUIAutomationPatternHandler
  IUIAutomationPatternHandler = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationPatternHandler)'}
  PIUIAutomationPatternHandler = ^IUIAutomationPatternHandler;

  // Windows  UI Automation.IUIAutomationRegistrar
  IUIAutomationRegistrar = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationRegistrar)'}
  PIUIAutomationRegistrar = ^IUIAutomationRegistrar;

  // Windows  UI Automation.IUIAutomationTransformPattern2
  IUIAutomationTransformPattern2 = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTransformPattern2)'}
  PIUIAutomationTransformPattern2 = ^IUIAutomationTransformPattern2;

  // Windows  UI Automation.IUIAutomationLegacyIAccessiblePattern
  IUIAutomationLegacyIAccessiblePattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationLegacyIAccessiblePattern)'}
  PIUIAutomationLegacyIAccessiblePattern = ^IUIAutomationLegacyIAccessiblePattern;

  // Windows  UI Automation.IUIAutomationNotCondition
  IUIAutomationNotCondition = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationNotCondition)'}
  PIUIAutomationNotCondition = ^IUIAutomationNotCondition;

  // Windows  UI Automation.IUIAutomationVirtualizedItemPattern
  IUIAutomationVirtualizedItemPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationVirtualizedItemPattern)'}
  PIUIAutomationVirtualizedItemPattern = ^IUIAutomationVirtualizedItemPattern;

  // Windows  UI Automation.IGridItemProvider
  IGridItemProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IGridItemProvider)'}
  PIGridItemProvider = ^IGridItemProvider;

  // Windows  UI Automation.IUIAutomationSpreadsheetPattern
  IUIAutomationSpreadsheetPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationSpreadsheetPattern)'}
  PIUIAutomationSpreadsheetPattern = ^IUIAutomationSpreadsheetPattern;

  // Windows  UI Automation.IUIAutomationRangeValuePattern
  IUIAutomationRangeValuePattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationRangeValuePattern)'}
  PIUIAutomationRangeValuePattern = ^IUIAutomationRangeValuePattern;

  // Windows  UI Automation.IUIAutomationTextChildPattern
  IUIAutomationTextChildPattern = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IUIAutomationTextChildPattern)'}
  PIUIAutomationTextChildPattern = ^IUIAutomationTextChildPattern;

  // Windows  UI Automation.ISpreadsheetProvider
  ISpreadsheetProvider = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISpreadsheetProvider)'}
  PISpreadsheetProvider = ^ISpreadsheetProvider;

  // Pointer type declarations for the record types that follow
  PUiaRect = ^UiaRect;
  PUiaChangesEventArgs = ^UiaChangesEventArgs;
  PHUIAEVENT = ^HUIAEVENT;
  PUIAutomationPatternInfo = ^UIAutomationPatternInfo;
  PFILTERKEYS = ^FILTERKEYS;
  PSOUNDSENTRYW = ^SOUNDSENTRYW;
  PSTICKYKEYS = ^STICKYKEYS;
  PUiaEventArgs = ^UiaEventArgs;
  PUiaChangeInfo = ^UiaChangeInfo;
  PUiaCacheRequest = ^UiaCacheRequest;
  PUIAutomationEventInfo = ^UIAutomationEventInfo;
  PSERIALKEYSW = ^SERIALKEYSW;
  PUiaFindParams = ^UiaFindParams;
  PUiaPoint = ^UiaPoint;
  PUiaCondition = ^UiaCondition;
  PUIAutomationParameter = ^UIAutomationParameter;
  PUiaAsyncContentLoadedEventArgs = ^UiaAsyncContentLoadedEventArgs;
  PHWINEVENTHOOK = ^HWINEVENTHOOK;
  PHUIAPATTERNOBJECT = ^HUIAPATTERNOBJECT;
  PHIGHCONTRASTW = ^HIGHCONTRASTW;
  PUIAutomationMethodInfo = ^UIAutomationMethodInfo;
  PSERIALKEYSA = ^SERIALKEYSA;
  PUiaPropertyChangedEventArgs = ^UiaPropertyChangedEventArgs;
  PMSAAMENUINFO = ^MSAAMENUINFO;
  PUiaWindowClosedEventArgs = ^UiaWindowClosedEventArgs;
  PUiaAndOrCondition = ^UiaAndOrCondition;
  PUiaStructureChangedEventArgs = ^UiaStructureChangedEventArgs;
  PSOUNDSENTRYA = ^SOUNDSENTRYA;
  PHUIATEXTRANGE = ^HUIATEXTRANGE;
  PHIGHCONTRASTA = ^HIGHCONTRASTA;
  PMOUSEKEYS = ^MOUSEKEYS;
  PExtendedProperty = ^ExtendedProperty;
  PUiaNotCondition = ^UiaNotCondition;
  PUiaTextEditTextChangedEventArgs = ^UiaTextEditTextChangedEventArgs;
  PACCESSTIMEOUT = ^ACCESSTIMEOUT;
  PUiaPropertyCondition = ^UiaPropertyCondition;
  PTOGGLEKEYS = ^TOGGLEKEYS;
  PHUIANODE = ^HUIANODE;
  PUIAutomationPropertyInfo = ^UIAutomationPropertyInfo;

  ///<remarks>
  ///<para>Invalid handle value: -1 or 0</para>
  ///</remarks>
  HUIAEVENT = IntPtr;
  {EXTERNALSYM HUIAEVENT}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/WinAuto/hwineventhook</summary>
  ///<remarks>
  ///<para>Free <c>HWINEVENTHOOK</c> with <c>UnhookWinEvent</c></para>
  ///<para>Invalid handle value: -1 or 0</para>
  ///</remarks>
  HWINEVENTHOOK = IntPtr;
  {EXTERNALSYM HWINEVENTHOOK}

  ///<remarks>
  ///<para>Invalid handle value: -1 or 0</para>
  ///</remarks>
  HUIAPATTERNOBJECT = IntPtr;
  {EXTERNALSYM HUIAPATTERNOBJECT}

  ///<remarks>
  ///<para>Invalid handle value: -1 or 0</para>
  ///</remarks>
  HUIATEXTRANGE = IntPtr;
  {EXTERNALSYM HUIATEXTRANGE}

  ///<remarks>
  ///<para>Invalid handle value: -1 or 0</para>
  ///</remarks>
  HUIANODE = IntPtr;
  {EXTERNALSYM HUIANODE}


  PWINEVENTPROC = ^WINEVENTPROC;
  PLPFNACCESSIBLECHILDREN = ^LPFNACCESSIBLECHILDREN;
  PLPFNLRESULTFROMOBJECT = ^LPFNLRESULTFROMOBJECT;
  PUiaEventCallback = ^UiaEventCallback;
  PLPFNOBJECTFROMLRESULT = ^LPFNOBJECTFROMLRESULT;
  PLPFNACCESSIBLEOBJECTFROMWINDOW = ^LPFNACCESSIBLEOBJECTFROMWINDOW;
  PUiaProviderCallback = ^UiaProviderCallback;
  PLPFNACCESSIBLEOBJECTFROMPOINT = ^LPFNACCESSIBLEOBJECTFROMPOINT;
  PLPFNCREATESTDACCESSIBLEOBJECT = ^LPFNCREATESTDACCESSIBLEOBJECT;

  WINEVENTPROC = procedure (hWinEventHook: HWINEVENTHOOK; event: Cardinal; hwnd: HWND; idObject: Integer; idChild: Integer; idEventThread: Cardinal; dwmsEventTime: Cardinal); stdcall;
  {$EXTERNALSYM WINEVENTPROC}

  LPFNACCESSIBLECHILDREN = function (paccContainer: IAccessible; iChildStart: Integer; cChildren: Integer; rgvarChildren: POleVariant; pcObtained: PInteger): HRESULT; stdcall;
  {$EXTERNALSYM LPFNACCESSIBLECHILDREN}

  LPFNLRESULTFROMOBJECT = function (riid: PGuid; wParam: WPARAM; punk: IUnknown): LRESULT; stdcall;
  {$EXTERNALSYM LPFNLRESULTFROMOBJECT}

  UiaEventCallback = procedure (pArgs: PUiaEventArgs; pRequestedData: PSAFEARRAY; pTreeStructure: PChar); stdcall;
  {$EXTERNALSYM UiaEventCallback}

  LPFNOBJECTFROMLRESULT = function (lResult: LRESULT; riid: PGuid; wParam: WPARAM; ppvObject: PPointer): HRESULT; stdcall;
  {$EXTERNALSYM LPFNOBJECTFROMLRESULT}

  LPFNACCESSIBLEOBJECTFROMWINDOW = function (hwnd: HWND; dwId: Cardinal; riid: PGuid; ppvObject: PPointer): HRESULT; stdcall;
  {$EXTERNALSYM LPFNACCESSIBLEOBJECTFROMWINDOW}

  UiaProviderCallback = function (hwnd: HWND; providerType: ProviderType): PSAFEARRAY; stdcall;
  {$EXTERNALSYM UiaProviderCallback}

  LPFNACCESSIBLEOBJECTFROMPOINT = function (ptScreen: TPointF; ppacc: PIAccessible; pvarChild: POleVariant): HRESULT; stdcall;
  {$EXTERNALSYM LPFNACCESSIBLEOBJECTFROMPOINT}

  LPFNCREATESTDACCESSIBLEOBJECT = function (hwnd: HWND; idObject: Integer; riid: PGuid; ppvObject: PPointer): HRESULT; stdcall;
  {$EXTERNALSYM LPFNCREATESTDACCESSIBLEOBJECT}

  // Windows  UI Automation Records

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiarect</summary>
  UiaRect = record
    left: Double;
    top: Double;
    width: Double;
    height: Double;
  end;
  {EXTERNALSYM UiaRect}

  UiaChangesEventArgs = record
    &Type: EventArgsType;
    EventId: Integer;
    EventIdCount: Integer;
    pUiaChanges: PUiaChangeInfo;
  end;
  {EXTERNALSYM UiaChangesEventArgs}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiautomationpatterninfo</summary>
  UIAutomationPatternInfo = record
    guid: TGuid;
    pProgrammaticName: PChar;
    providerInterfaceId: TGuid;
    clientInterfaceId: TGuid;
    cProperties: Cardinal;
    pProperties: PUIAutomationPropertyInfo;
    cMethods: Cardinal;
    pMethods: PUIAutomationMethodInfo;
    cEvents: Cardinal;
    pEvents: PUIAutomationEventInfo;
    pPatternHandler: IUIAutomationPatternHandler;
  end;
  {EXTERNALSYM UIAutomationPatternInfo}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-filterkeys</summary>
  ///<remarks>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  FILTERKEYS = record
    cbSize: Cardinal;
    dwFlags: Cardinal;
    iWaitMSec: Cardinal;
    iDelayMSec: Cardinal;
    iRepeatMSec: Cardinal;
    iBounceMSec: Cardinal;
  end;
  {EXTERNALSYM FILTERKEYS}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-soundsentryw</summary>
  ///<remarks>
  ///<para>Uses Unicode text strings</para>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  SOUNDSENTRYW = record
    cbSize: Cardinal;
    dwFlags: SOUNDSENTRY_FLAGS;
    iFSTextEffect: SOUNDSENTRY_TEXT_EFFECT;
    iFSTextEffectMSec: Cardinal;
    iFSTextEffectColorBits: Cardinal;
    iFSGrafEffect: SOUND_SENTRY_GRAPHICS_EFFECT;
    iFSGrafEffectMSec: Cardinal;
    iFSGrafEffectColor: Cardinal;
    iWindowsEffect: SOUNDSENTRY_WINDOWS_EFFECT;
    iWindowsEffectMSec: Cardinal;
    lpszWindowsEffectDLL: PChar;
    iWindowsEffectOrdinal: Cardinal;
  end;
  {EXTERNALSYM SOUNDSENTRYW}
  SOUNDSENTRY = SOUNDSENTRYW;

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-stickykeys</summary>
  ///<remarks>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  STICKYKEYS = record
    cbSize: Cardinal;
    dwFlags: STICKYKEYS_FLAGS;
  end;
  {EXTERNALSYM STICKYKEYS}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiaeventargs</summary>
  UiaEventArgs = record
    &Type: EventArgsType;
    EventId: Integer;
  end;
  {EXTERNALSYM UiaEventArgs}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiachangeinfo</summary>
  UiaChangeInfo = record
    uiaId: Integer;
    payload: OleVariant;
    extraInfo: OleVariant;
  end;
  {EXTERNALSYM UiaChangeInfo}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiacacherequest</summary>
  UiaCacheRequest = record
    pViewCondition: PUiaCondition;
    Scope: TreeScope;
    pProperties: PInteger;
    cProperties: Integer;
    pPatterns: PInteger;
    cPatterns: Integer;
    automationElementMode: AutomationElementMode;
  end;
  {EXTERNALSYM UiaCacheRequest}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiautomationeventinfo</summary>
  UIAutomationEventInfo = record
    guid: TGuid;
    pProgrammaticName: PChar;
  end;
  {EXTERNALSYM UIAutomationEventInfo}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-serialkeysw</summary>
  ///<remarks>
  ///<para>Uses Unicode text strings</para>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  SERIALKEYSW = record
    cbSize: Cardinal;
    dwFlags: SERIALKEYS_FLAGS;
    lpszActivePort: PChar;
    lpszPort: PChar;
    iBaudRate: Cardinal;
    iPortState: Cardinal;
    iActive: Cardinal;
  end;
  {EXTERNALSYM SERIALKEYSW}
  SERIALKEYS = SERIALKEYSW;

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiafindparams</summary>
  UiaFindParams = record
    MaxDepth: Integer;
    FindFirst: BOOL;
    ExcludeRoot: BOOL;
    pFindCondition: PUiaCondition;
  end;
  {EXTERNALSYM UiaFindParams}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiapoint</summary>
  UiaPoint = record
    x: Double;
    y: Double;
  end;
  {EXTERNALSYM UiaPoint}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiacondition</summary>
  UiaCondition = record
    ConditionType: ConditionType;
  end;
  {EXTERNALSYM UiaCondition}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiautomationparameter</summary>
  UIAutomationParameter = record
    &type: UIAutomationType;
    pData: Pointer;
  end;
  {EXTERNALSYM UIAutomationParameter}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiaasynccontentloadedeventargs</summary>
  UiaAsyncContentLoadedEventArgs = record
    &Type: EventArgsType;
    EventId: Integer;
    AsyncContentLoadedState: AsyncContentLoadedState;
    PercentComplete: Double;
  end;
  {EXTERNALSYM UiaAsyncContentLoadedEventArgs}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-highcontrastw</summary>
  ///<remarks>
  ///<para>Uses Unicode text strings</para>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  HIGHCONTRASTW = record
    cbSize: Cardinal;
    dwFlags: HIGHCONTRASTW_FLAGS;
    lpszDefaultScheme: PChar;
  end;
  {EXTERNALSYM HIGHCONTRASTW}
  HIGHCONTRAST = HIGHCONTRASTW;

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiautomationmethodinfo</summary>
  UIAutomationMethodInfo = record
    pProgrammaticName: PChar;
    doSetFocus: BOOL;
    cInParameters: Cardinal;
    cOutParameters: Cardinal;
    pParameterTypes: PUIAutomationType;
    pParameterNames: PPChar;
  end;
  {EXTERNALSYM UIAutomationMethodInfo}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-serialkeysa</summary>
  ///<remarks>
  ///<para>Uses Ansi text strings</para>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  SERIALKEYSA = record
    cbSize: Cardinal;
    dwFlags: SERIALKEYS_FLAGS;
    lpszActivePort: PByte;
    lpszPort: PByte;
    iBaudRate: Cardinal;
    iPortState: Cardinal;
    iActive: Cardinal;
  end;
  {EXTERNALSYM SERIALKEYSA}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiapropertychangedeventargs</summary>
  UiaPropertyChangedEventArgs = record
    &Type: EventArgsType;
    EventId: UIA_EVENT_ID;
    PropertyId: Integer;
    OldValue: OleVariant;
    NewValue: OleVariant;
  end;
  {EXTERNALSYM UiaPropertyChangedEventArgs}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/ns-oleacc-msaamenuinfo</summary>
  MSAAMENUINFO = record
    dwMSAASignature: Cardinal;
    cchWText: Cardinal;
    pszWText: PChar;
  end;
  {EXTERNALSYM MSAAMENUINFO}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiawindowclosedeventargs</summary>
  UiaWindowClosedEventArgs = record
    &Type: EventArgsType;
    EventId: Integer;
    pRuntimeId: PInteger;
    cRuntimeIdLen: Integer;
  end;
  {EXTERNALSYM UiaWindowClosedEventArgs}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiaandorcondition</summary>
  UiaAndOrCondition = record
    ConditionType: ConditionType;
    ppConditions: PUiaCondition;
    cConditions: Integer;
  end;
  {EXTERNALSYM UiaAndOrCondition}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiastructurechangedeventargs</summary>
  UiaStructureChangedEventArgs = record
    &Type: EventArgsType;
    EventId: Integer;
    StructureChangeType: StructureChangeType;
    pRuntimeId: PInteger;
    cRuntimeIdLen: Integer;
  end;
  {EXTERNALSYM UiaStructureChangedEventArgs}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-soundsentrya</summary>
  ///<remarks>
  ///<para>Uses Ansi text strings</para>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  SOUNDSENTRYA = record
    cbSize: Cardinal;
    dwFlags: SOUNDSENTRY_FLAGS;
    iFSTextEffect: SOUNDSENTRY_TEXT_EFFECT;
    iFSTextEffectMSec: Cardinal;
    iFSTextEffectColorBits: Cardinal;
    iFSGrafEffect: SOUND_SENTRY_GRAPHICS_EFFECT;
    iFSGrafEffectMSec: Cardinal;
    iFSGrafEffectColor: Cardinal;
    iWindowsEffect: SOUNDSENTRY_WINDOWS_EFFECT;
    iWindowsEffectMSec: Cardinal;
    lpszWindowsEffectDLL: PByte;
    iWindowsEffectOrdinal: Cardinal;
  end;
  {EXTERNALSYM SOUNDSENTRYA}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-highcontrasta</summary>
  ///<remarks>
  ///<para>Uses Ansi text strings</para>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  HIGHCONTRASTA = record
    cbSize: Cardinal;
    dwFlags: HIGHCONTRASTW_FLAGS;
    lpszDefaultScheme: PByte;
  end;
  {EXTERNALSYM HIGHCONTRASTA}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-mousekeys</summary>
  ///<remarks>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  MOUSEKEYS = record
    cbSize: Cardinal;
    dwFlags: Cardinal;
    iMaxSpeed: Cardinal;
    iTimeToMaxSpeed: Cardinal;
    iCtrlSpeed: Cardinal;
    dwReserved1: Cardinal;
    dwReserved2: Cardinal;
  end;
  {EXTERNALSYM MOUSEKEYS}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/SecCrypto/extendedproperty</summary>
  ExtendedProperty = record
    PropertyName: PChar;
    PropertyValue: PChar;
  end;
  {EXTERNALSYM ExtendedProperty}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uianotcondition</summary>
  UiaNotCondition = record
    ConditionType: ConditionType;
    pCondition: PUiaCondition;
  end;
  {EXTERNALSYM UiaNotCondition}

  UiaTextEditTextChangedEventArgs = record
    &Type: EventArgsType;
    EventId: Integer;
    TextEditChangeType: TextEditChangeType;
    pTextChange: PSAFEARRAY;
  end;
  {EXTERNALSYM UiaTextEditTextChangedEventArgs}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-accesstimeout</summary>
  ///<remarks>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  ACCESSTIMEOUT = record
    cbSize: Cardinal;
    dwFlags: Cardinal;
    iTimeOutMSec: Cardinal;
  end;
  {EXTERNALSYM ACCESSTIMEOUT}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiapropertycondition</summary>
  UiaPropertyCondition = record
    ConditionType: ConditionType;
    PropertyId: UIA_PROPERTY_ID;
    Value: OleVariant;
    Flags: PropertyConditionFlags;
  end;
  {EXTERNALSYM UiaPropertyCondition}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/winuser/ns-winuser-togglekeys</summary>
  ///<remarks>
  ///<para><c>cbSize</c> is the record size field</para>
  ///</remarks>
  TOGGLEKEYS = record
    cbSize: Cardinal;
    dwFlags: Cardinal;
  end;
  {EXTERNALSYM TOGGLEKEYS}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiautomationpropertyinfo</summary>
  UIAutomationPropertyInfo = record
    guid: TGuid;
    pProgrammaticName: PChar;
    &type: UIAutomationType;
  end;
  {EXTERNALSYM UIAutomationPropertyInfo}

  // Windows  UI Automation Interfaces

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationcondition</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationCondition = interface(IUnknown)
  ['{352FFBA8-0973-437C-A61F-F64CAFD81DF9}']
  end;
  {$EXTERNALSYM IUIAutomationCondition}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelementarray</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationElementArray = interface(IUnknown)
  ['{14314595-B4BC-4055-95F2-58F2E42C9855}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelementarray-get_length</summary>
    function get_Length(out length: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelementarray-getelement</summary>
    function GetElement(index: Integer; out element: IUIAutomationElement): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationElementArray}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationcacherequest</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationCacheRequest = interface(IUnknown)
  ['{B32A92B5-BC25-4078-9C08-D7EE95C48E03}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-addproperty</summary>
    function AddProperty(propertyId: UIA_PROPERTY_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-addpattern</summary>
    function AddPattern(patternId: UIA_PATTERN_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-clone</summary>
    function Clone(out clonedRequest: IUIAutomationCacheRequest): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-get_treescope</summary>
    function get_TreeScope(out scope: TreeScope): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-put_treescope</summary>
    function put_TreeScope(scope: TreeScope): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-get_treefilter</summary>
    function get_TreeFilter(out filter: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-put_treefilter</summary>
    function put_TreeFilter(filter: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-get_automationelementmode</summary>
    function get_AutomationElementMode(out mode: AutomationElementMode): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-put_automationelementmode</summary>
    function put_AutomationElementMode(mode: AutomationElementMode): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationCacheRequest}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationElement = interface(IUnknown)
  ['{D22108AA-8AC5-49A5-837B-37BBB3D7591E}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-setfocus</summary>
    function SetFocus: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getruntimeid</summary>
    function GetRuntimeId(out runtimeId: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-findfirst</summary>
    function FindFirst(scope: TreeScope; condition: IUIAutomationCondition; out found: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-findall</summary>
    function FindAll(scope: TreeScope; condition: IUIAutomationCondition; out found: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-findfirstbuildcache</summary>
    function FindFirstBuildCache(scope: TreeScope; condition: IUIAutomationCondition; cacheRequest: IUIAutomationCacheRequest; out found: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-findallbuildcache</summary>
    function FindAllBuildCache(scope: TreeScope; condition: IUIAutomationCondition; cacheRequest: IUIAutomationCacheRequest; out found: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-buildupdatedcache</summary>
    function BuildUpdatedCache(cacheRequest: IUIAutomationCacheRequest; out updatedElement: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpropertyvalue</summary>
    function GetCurrentPropertyValue(propertyId: UIA_PROPERTY_ID; out retVal: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpropertyvalueex</summary>
    function GetCurrentPropertyValueEx(propertyId: UIA_PROPERTY_ID; ignoreDefaultValue: BOOL; out retVal: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedpropertyvalue</summary>
    function GetCachedPropertyValue(propertyId: UIA_PROPERTY_ID; out retVal: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedpropertyvalueex</summary>
    function GetCachedPropertyValueEx(propertyId: UIA_PROPERTY_ID; ignoreDefaultValue: BOOL; out retVal: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpatternas</summary>
    function GetCurrentPatternAs(patternId: UIA_PATTERN_ID; riid: PGuid; out patternObject: Pointer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedpatternas</summary>
    function GetCachedPatternAs(patternId: UIA_PATTERN_ID; riid: PGuid; out patternObject: Pointer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpattern</summary>
    function GetCurrentPattern(patternId: UIA_PATTERN_ID; out patternObject: IUnknown): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedpattern</summary>
    function GetCachedPattern(patternId: UIA_PATTERN_ID; out patternObject: IUnknown): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedparent</summary>
    function GetCachedParent(out parent: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedchildren</summary>
    function GetCachedChildren(out children: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentprocessid</summary>
    function get_CurrentProcessId(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentcontroltype</summary>
    function get_CurrentControlType(out retVal: UIA_CONTROLTYPE_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentlocalizedcontroltype</summary>
    function get_CurrentLocalizedControlType(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentname</summary>
    function get_CurrentName(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentacceleratorkey</summary>
    function get_CurrentAcceleratorKey(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentaccesskey</summary>
    function get_CurrentAccessKey(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currenthaskeyboardfocus</summary>
    function get_CurrentHasKeyboardFocus(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentiskeyboardfocusable</summary>
    function get_CurrentIsKeyboardFocusable(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisenabled</summary>
    function get_CurrentIsEnabled(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentautomationid</summary>
    function get_CurrentAutomationId(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentclassname</summary>
    function get_CurrentClassName(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currenthelptext</summary>
    function get_CurrentHelpText(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentculture</summary>
    function get_CurrentCulture(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentiscontrolelement</summary>
    function get_CurrentIsControlElement(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentiscontentelement</summary>
    function get_CurrentIsContentElement(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentispassword</summary>
    function get_CurrentIsPassword(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentnativewindowhandle</summary>
    function get_CurrentNativeWindowHandle(out retVal: HWND): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentitemtype</summary>
    function get_CurrentItemType(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisoffscreen</summary>
    function get_CurrentIsOffscreen(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentorientation</summary>
    function get_CurrentOrientation(out retVal: OrientationType): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentframeworkid</summary>
    function get_CurrentFrameworkId(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisrequiredforform</summary>
    function get_CurrentIsRequiredForForm(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentitemstatus</summary>
    function get_CurrentItemStatus(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentboundingrectangle</summary>
    function get_CurrentBoundingRectangle(out retVal: TRectF): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentlabeledby</summary>
    function get_CurrentLabeledBy(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentariarole</summary>
    function get_CurrentAriaRole(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentariaproperties</summary>
    function get_CurrentAriaProperties(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisdatavalidforform</summary>
    function get_CurrentIsDataValidForForm(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentcontrollerfor</summary>
    function get_CurrentControllerFor(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentdescribedby</summary>
    function get_CurrentDescribedBy(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentflowsto</summary>
    function get_CurrentFlowsTo(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentproviderdescription</summary>
    function get_CurrentProviderDescription(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedprocessid</summary>
    function get_CachedProcessId(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedcontroltype</summary>
    function get_CachedControlType(out retVal: UIA_CONTROLTYPE_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedlocalizedcontroltype</summary>
    function get_CachedLocalizedControlType(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedname</summary>
    function get_CachedName(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedacceleratorkey</summary>
    function get_CachedAcceleratorKey(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedaccesskey</summary>
    function get_CachedAccessKey(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedhaskeyboardfocus</summary>
    function get_CachedHasKeyboardFocus(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachediskeyboardfocusable</summary>
    function get_CachedIsKeyboardFocusable(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedisenabled</summary>
    function get_CachedIsEnabled(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedautomationid</summary>
    function get_CachedAutomationId(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedclassname</summary>
    function get_CachedClassName(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedhelptext</summary>
    function get_CachedHelpText(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedculture</summary>
    function get_CachedCulture(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachediscontrolelement</summary>
    function get_CachedIsControlElement(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachediscontentelement</summary>
    function get_CachedIsContentElement(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedispassword</summary>
    function get_CachedIsPassword(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachednativewindowhandle</summary>
    function get_CachedNativeWindowHandle(out retVal: HWND): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cacheditemtype</summary>
    function get_CachedItemType(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedisoffscreen</summary>
    function get_CachedIsOffscreen(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedorientation</summary>
    function get_CachedOrientation(out retVal: OrientationType): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedframeworkid</summary>
    function get_CachedFrameworkId(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedisrequiredforform</summary>
    function get_CachedIsRequiredForForm(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cacheditemstatus</summary>
    function get_CachedItemStatus(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedboundingrectangle</summary>
    function get_CachedBoundingRectangle(out retVal: TRectF): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedlabeledby</summary>
    function get_CachedLabeledBy(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedariarole</summary>
    function get_CachedAriaRole(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedariaproperties</summary>
    function get_CachedAriaProperties(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedisdatavalidforform</summary>
    function get_CachedIsDataValidForForm(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedcontrollerfor</summary>
    function get_CachedControllerFor(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cacheddescribedby</summary>
    function get_CachedDescribedBy(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedflowsto</summary>
    function get_CachedFlowsTo(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedproviderdescription</summary>
    function get_CachedProviderDescription(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getclickablepoint</summary>
    function GetClickablePoint(out clickable: TPointF; out gotClickable: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationElement}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtreewalker</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationTreeWalker = interface(IUnknown)
  ['{4042C624-389C-4AFC-A630-9DF854A541FC}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getparentelement</summary>
    function GetParentElement(element: IUIAutomationElement; out parent: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getfirstchildelement</summary>
    function GetFirstChildElement(element: IUIAutomationElement; out first: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getlastchildelement</summary>
    function GetLastChildElement(element: IUIAutomationElement; out last: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getnextsiblingelement</summary>
    function GetNextSiblingElement(element: IUIAutomationElement; out next: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getprevioussiblingelement</summary>
    function GetPreviousSiblingElement(element: IUIAutomationElement; out previous: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-normalizeelement</summary>
    function NormalizeElement(element: IUIAutomationElement; out normalized: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getparentelementbuildcache</summary>
    function GetParentElementBuildCache(element: IUIAutomationElement; cacheRequest: IUIAutomationCacheRequest; out parent: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getfirstchildelementbuildcache</summary>
    function GetFirstChildElementBuildCache(element: IUIAutomationElement; cacheRequest: IUIAutomationCacheRequest; out first: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getlastchildelementbuildcache</summary>
    function GetLastChildElementBuildCache(element: IUIAutomationElement; cacheRequest: IUIAutomationCacheRequest; out last: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getnextsiblingelementbuildcache</summary>
    function GetNextSiblingElementBuildCache(element: IUIAutomationElement; cacheRequest: IUIAutomationCacheRequest; out next: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getprevioussiblingelementbuildcache</summary>
    function GetPreviousSiblingElementBuildCache(element: IUIAutomationElement; cacheRequest: IUIAutomationCacheRequest; out previous: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-normalizeelementbuildcache</summary>
    function NormalizeElementBuildCache(element: IUIAutomationElement; cacheRequest: IUIAutomationCacheRequest; out normalized: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-get_condition</summary>
    function get_Condition(out condition: IUIAutomationCondition): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTreeWalker}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationeventhandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationEventHandler = interface(IUnknown)
  ['{146C3C17-F12E-4E22-8C27-F894B9B79C69}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandler-handleautomationevent</summary>
    function HandleAutomationEvent(sender: IUIAutomationElement; eventId: UIA_EVENT_ID): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationEventHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationpropertychangedeventhandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationPropertyChangedEventHandler = interface(IUnknown)
  ['{40CD37D4-C756-4B0C-8C6F-BDDFEEB13B50}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationpropertychangedeventhandler-handlepropertychangedevent</summary>
    function HandlePropertyChangedEvent(sender: IUIAutomationElement; propertyId: UIA_PROPERTY_ID; newValue: OleVariant): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationPropertyChangedEventHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationstructurechangedeventhandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationStructureChangedEventHandler = interface(IUnknown)
  ['{E81D1B4E-11C5-42F8-9754-E7036C79F054}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstructurechangedeventhandler-handlestructurechangedevent</summary>
    function HandleStructureChangedEvent(sender: IUIAutomationElement; changeType: StructureChangeType; runtimeId: PSAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationStructureChangedEventHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationfocuschangedeventhandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationFocusChangedEventHandler = interface(IUnknown)
  ['{C270F6B5-5C69-4290-9745-7A7F97169468}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationfocuschangedeventhandler-handlefocuschangedevent</summary>
    function HandleFocusChangedEvent(sender: IUIAutomationElement): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationFocusChangedEventHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementprovidersimple</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IRawElementProviderSimple = interface(IUnknown)
  ['{D6DD68D1-86FD-4332-8666-9ABEDEA2D24C}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple-get_provideroptions</summary>
    function get_ProviderOptions(out pRetVal: ProviderOptions): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple-getpatternprovider</summary>
    function GetPatternProvider(patternId: UIA_PATTERN_ID; out pRetVal: IUnknown): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple-getpropertyvalue</summary>
    function GetPropertyValue(propertyId: UIA_PROPERTY_ID; out pRetVal: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple-get_hostrawelementprovider</summary>
    function get_HostRawElementProvider(out pRetVal: IRawElementProviderSimple): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRawElementProviderSimple}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationproxyfactory</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationProxyFactory = interface(IUnknown)
  ['{85B94ECD-849D-42B6-B94D-D6DB23FDF5A4}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactory-createprovider</summary>
    function CreateProvider(hwnd: HWND; idObject: Integer; idChild: Integer; out provider: IRawElementProviderSimple): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactory-get_proxyfactoryid</summary>
    function get_ProxyFactoryId(out factoryId: PChar): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationProxyFactory}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationproxyfactoryentry</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationProxyFactoryEntry = interface(IUnknown)
  ['{D50E472E-B64B-490C-BCA1-D30696F9F289}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_proxyfactory</summary>
    function get_ProxyFactory(out factory: IUIAutomationProxyFactory): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_classname</summary>
    function get_ClassName(out className: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_imagename</summary>
    function get_ImageName(out imageName: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_allowsubstringmatch</summary>
    function get_AllowSubstringMatch(out allowSubstringMatch: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_cancheckbaseclass</summary>
    function get_CanCheckBaseClass(out canCheckBaseClass: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_needsadviseevents</summary>
    function get_NeedsAdviseEvents(out adviseEvents: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-put_classname</summary>
    function put_ClassName(className: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-put_imagename</summary>
    function put_ImageName(imageName: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-put_allowsubstringmatch</summary>
    function put_AllowSubstringMatch(allowSubstringMatch: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-put_cancheckbaseclass</summary>
    function put_CanCheckBaseClass(canCheckBaseClass: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-put_needsadviseevents</summary>
    function put_NeedsAdviseEvents(adviseEvents: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-setwineventsforautomationevent</summary>
    function SetWinEventsForAutomationEvent(eventId: UIA_EVENT_ID; propertyId: UIA_PROPERTY_ID; winEvents: PSAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-getwineventsforautomationevent</summary>
    function GetWinEventsForAutomationEvent(eventId: UIA_EVENT_ID; propertyId: UIA_PROPERTY_ID; out winEvents: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationProxyFactoryEntry}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationproxyfactorymapping</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationProxyFactoryMapping = interface(IUnknown)
  ['{09E31E18-872D-4873-93D1-1E541EC133FD}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-get_count</summary>
    function get_Count(out count: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-gettable</summary>
    function GetTable(out table: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-getentry</summary>
    function GetEntry(index: Cardinal; out entry: IUIAutomationProxyFactoryEntry): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-settable</summary>
    function SetTable(factoryList: PSAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-insertentries</summary>
    function InsertEntries(before: Cardinal; factoryList: PSAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-insertentry</summary>
    function InsertEntry(before: Cardinal; factory: IUIAutomationProxyFactoryEntry): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-removeentry</summary>
    function RemoveEntry(index: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-cleartable</summary>
    function ClearTable: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-restoredefaulttable</summary>
    function RestoreDefaultTable: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationProxyFactoryMapping}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccessible</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.0</i></para>
  ///</remarks>
  IAccessible = interface(IDispatch)
  ['{618736E0-3C3D-11CF-810C-00AA00389B71}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accparent</summary>
    function get_accParent(out ppdispParent: IDispatch): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accchildcount</summary>
    function get_accChildCount(out pcountChildren: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accchild</summary>
    function get_accChild(varChild: OleVariant; out ppdispChild: IDispatch): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accname</summary>
    function get_accName(varChild: OleVariant; out pszName: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accvalue</summary>
    function get_accValue(varChild: OleVariant; out pszValue: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accdescription</summary>
    function get_accDescription(varChild: OleVariant; out pszDescription: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accrole</summary>
    function get_accRole(varChild: OleVariant; out pvarRole: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accstate</summary>
    function get_accState(varChild: OleVariant; out pvarState: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_acchelp</summary>
    function get_accHelp(varChild: OleVariant; out pszHelp: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_acchelptopic</summary>
    function get_accHelpTopic(out pszHelpFile: PChar; varChild: OleVariant; out pidTopic: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_acckeyboardshortcut</summary>
    function get_accKeyboardShortcut(varChild: OleVariant; out pszKeyboardShortcut: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accfocus</summary>
    function get_accFocus(out pvarChild: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accselection</summary>
    function get_accSelection(out pvarChildren: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accdefaultaction</summary>
    function get_accDefaultAction(varChild: OleVariant; out pszDefaultAction: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-accselect</summary>
    function accSelect(flagsSelect: Integer; varChild: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-acclocation</summary>
    function accLocation(out pxLeft: Integer; out pyTop: Integer; out pcxWidth: Integer; out pcyHeight: Integer; varChild: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-accnavigate</summary>
    function accNavigate(navDir: Integer; varStart: OleVariant; out pvarEndUpAt: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-acchittest</summary>
    function accHitTest(xLeft: Integer; yTop: Integer; out pvarChild: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-accdodefaultaction</summary>
    function accDoDefaultAction(varChild: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-put_accname</summary>
    function put_accName(varChild: OleVariant; szName: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-put_accvalue</summary>
    function put_accValue(varChild: OleVariant; szValue: PChar): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IAccessible}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomation = interface(IUnknown)
  ['{30CBE57D-D9D0-452A-AB13-7AC5AC4825EE}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-compareelements</summary>
    function CompareElements(el1: IUIAutomationElement; el2: IUIAutomationElement; out areSame: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-compareruntimeids</summary>
    function CompareRuntimeIds(runtimeId1: PSAFEARRAY; runtimeId2: PSAFEARRAY; out areSame: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getrootelement</summary>
    function GetRootElement(out root: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfromhandle</summary>
    function ElementFromHandle(hwnd: HWND; out element: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfrompoint</summary>
    function ElementFromPoint(pt: TPointF; out element: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getfocusedelement</summary>
    function GetFocusedElement(out element: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getrootelementbuildcache</summary>
    function GetRootElementBuildCache(cacheRequest: IUIAutomationCacheRequest; out root: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfromhandlebuildcache</summary>
    function ElementFromHandleBuildCache(hwnd: HWND; cacheRequest: IUIAutomationCacheRequest; out element: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfrompointbuildcache</summary>
    function ElementFromPointBuildCache(pt: TPointF; cacheRequest: IUIAutomationCacheRequest; out element: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getfocusedelementbuildcache</summary>
    function GetFocusedElementBuildCache(cacheRequest: IUIAutomationCacheRequest; out element: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createtreewalker</summary>
    function CreateTreeWalker(pCondition: IUIAutomationCondition; out walker: IUIAutomationTreeWalker): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_controlviewwalker</summary>
    function get_ControlViewWalker(out walker: IUIAutomationTreeWalker): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_contentviewwalker</summary>
    function get_ContentViewWalker(out walker: IUIAutomationTreeWalker): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_rawviewwalker</summary>
    function get_RawViewWalker(out walker: IUIAutomationTreeWalker): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_rawviewcondition</summary>
    function get_RawViewCondition(out condition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_controlviewcondition</summary>
    function get_ControlViewCondition(out condition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_contentviewcondition</summary>
    function get_ContentViewCondition(out condition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createcacherequest</summary>
    function CreateCacheRequest(out cacheRequest: IUIAutomationCacheRequest): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createtruecondition</summary>
    function CreateTrueCondition(out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createfalsecondition</summary>
    function CreateFalseCondition(out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createpropertycondition</summary>
    function CreatePropertyCondition(propertyId: UIA_PROPERTY_ID; value: OleVariant; out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createpropertyconditionex</summary>
    function CreatePropertyConditionEx(propertyId: UIA_PROPERTY_ID; value: OleVariant; flags: PropertyConditionFlags; out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createandcondition</summary>
    function CreateAndCondition(condition1: IUIAutomationCondition; condition2: IUIAutomationCondition; out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createandconditionfromarray</summary>
    function CreateAndConditionFromArray(conditions: PSAFEARRAY; out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createandconditionfromnativearray</summary>
    function CreateAndConditionFromNativeArray(conditions: PIUIAutomationCondition; conditionCount: Integer; out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createorcondition</summary>
    function CreateOrCondition(condition1: IUIAutomationCondition; condition2: IUIAutomationCondition; out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createorconditionfromarray</summary>
    function CreateOrConditionFromArray(conditions: PSAFEARRAY; out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createorconditionfromnativearray</summary>
    function CreateOrConditionFromNativeArray(conditions: PIUIAutomationCondition; conditionCount: Integer; out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createnotcondition</summary>
    function CreateNotCondition(condition: IUIAutomationCondition; out newCondition: IUIAutomationCondition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-addautomationeventhandler</summary>
    function AddAutomationEventHandler(eventId: UIA_EVENT_ID; element: IUIAutomationElement; scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-removeautomationeventhandler</summary>
    function RemoveAutomationEventHandler(eventId: UIA_EVENT_ID; element: IUIAutomationElement; handler: IUIAutomationEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-addpropertychangedeventhandlernativearray</summary>
    function AddPropertyChangedEventHandlerNativeArray(element: IUIAutomationElement; scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationPropertyChangedEventHandler; propertyArray: PUIA_PROPERTY_ID; propertyCount: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-addpropertychangedeventhandler</summary>
    function AddPropertyChangedEventHandler(element: IUIAutomationElement; scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationPropertyChangedEventHandler; propertyArray: PSAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-removepropertychangedeventhandler</summary>
    function RemovePropertyChangedEventHandler(element: IUIAutomationElement; handler: IUIAutomationPropertyChangedEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-addstructurechangedeventhandler</summary>
    function AddStructureChangedEventHandler(element: IUIAutomationElement; scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationStructureChangedEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-removestructurechangedeventhandler</summary>
    function RemoveStructureChangedEventHandler(element: IUIAutomationElement; handler: IUIAutomationStructureChangedEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-addfocuschangedeventhandler</summary>
    function AddFocusChangedEventHandler(cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationFocusChangedEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-removefocuschangedeventhandler</summary>
    function RemoveFocusChangedEventHandler(handler: IUIAutomationFocusChangedEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-removealleventhandlers</summary>
    function RemoveAllEventHandlers: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-intnativearraytosafearray</summary>
    function IntNativeArrayToSafeArray(&array: PInteger; arrayCount: Integer; out safeArray: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-intsafearraytonativearray</summary>
    function IntSafeArrayToNativeArray(intArray: PSAFEARRAY; out &array: Integer; out arrayCount: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-recttovariant</summary>
    function RectToVariant(rc: TRectF; out &var: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-varianttorect</summary>
    function VariantToRect(&var: OleVariant; out rc: TRectF): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-safearraytorectnativearray</summary>
    function SafeArrayToRectNativeArray(rects: PSAFEARRAY; out rectArray: TRectF; out rectArrayCount: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createproxyfactoryentry</summary>
    function CreateProxyFactoryEntry(factory: IUIAutomationProxyFactory; out factoryEntry: IUIAutomationProxyFactoryEntry): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_proxyfactorymapping</summary>
    function get_ProxyFactoryMapping(out factoryMapping: IUIAutomationProxyFactoryMapping): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getpropertyprogrammaticname</summary>
    function GetPropertyProgrammaticName(&property: UIA_PROPERTY_ID; out name: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getpatternprogrammaticname</summary>
    function GetPatternProgrammaticName(pattern: UIA_PATTERN_ID; out name: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-pollforpotentialsupportedpatterns</summary>
    function PollForPotentialSupportedPatterns(pElement: IUIAutomationElement; out patternIds: SAFEARRAY; out patternNames: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-pollforpotentialsupportedproperties</summary>
    function PollForPotentialSupportedProperties(pElement: IUIAutomationElement; out propertyIds: SAFEARRAY; out propertyNames: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-checknotsupported</summary>
    function CheckNotSupported(value: OleVariant; out isNotSupported: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_reservednotsupportedvalue</summary>
    function get_ReservedNotSupportedValue(out notSupportedValue: IUnknown): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_reservedmixedattributevalue</summary>
    function get_ReservedMixedAttributeValue(out mixedAttributeValue: IUnknown): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfromiaccessible</summary>
    function ElementFromIAccessible(accessible: IAccessible; childId: Integer; out element: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfromiaccessiblebuildcache</summary>
    function ElementFromIAccessibleBuildCache(accessible: IAccessible; childId: Integer; cacheRequest: IUIAutomationCacheRequest; out element: IUIAutomationElement): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomation}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrange</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationTextRange = interface(IUnknown)
  ['{A543CC6A-F4AE-494B-8239-C814481187A8}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-clone</summary>
    function Clone(out clonedRange: IUIAutomationTextRange): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-compare</summary>
    function Compare(range: IUIAutomationTextRange; out areSame: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-compareendpoints</summary>
    function CompareEndpoints(srcEndPoint: TextPatternRangeEndpoint; range: IUIAutomationTextRange; targetEndPoint: TextPatternRangeEndpoint; out compValue: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-expandtoenclosingunit</summary>
    function ExpandToEnclosingUnit(textUnit: TextUnit): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-findattribute</summary>
    function FindAttribute(attr: UIA_TEXTATTRIBUTE_ID; val: OleVariant; backward: BOOL; out found: IUIAutomationTextRange): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-findtext</summary>
    function FindText(text: PChar; backward: BOOL; ignoreCase: BOOL; out found: IUIAutomationTextRange): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getattributevalue</summary>
    function GetAttributeValue(attr: UIA_TEXTATTRIBUTE_ID; out value: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getboundingrectangles</summary>
    function GetBoundingRectangles(out boundingRects: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getenclosingelement</summary>
    function GetEnclosingElement(out enclosingElement: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-gettext</summary>
    function GetText(maxLength: Integer; out text: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-move</summary>
    function Move(&unit: TextUnit; count: Integer; out moved: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-moveendpointbyunit</summary>
    function MoveEndpointByUnit(endpoint: TextPatternRangeEndpoint; &unit: TextUnit; count: Integer; out moved: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-moveendpointbyrange</summary>
    function MoveEndpointByRange(srcEndPoint: TextPatternRangeEndpoint; range: IUIAutomationTextRange; targetEndPoint: TextPatternRangeEndpoint): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-select</summary>
    function Select: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-addtoselection</summary>
    function AddToSelection: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-removefromselection</summary>
    function RemoveFromSelection: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-scrollintoview</summary>
    function ScrollIntoView(alignToTop: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getchildren</summary>
    function GetChildren(out children: IUIAutomationElementArray): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTextRange}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iaccessibleex</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IAccessibleEx = interface(IUnknown)
  ['{F8B80ADA-2C44-48D0-89BE-5FF23C9CD875}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessibleex-getobjectforchild</summary>
    function GetObjectForChild(idChild: Integer; out pRetVal: IAccessibleEx): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessibleex-getiaccessiblepair</summary>
    function GetIAccessiblePair(out ppAcc: IAccessible; out pidChild: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessibleex-getruntimeid</summary>
    function GetRuntimeId(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessibleex-convertreturnedelement</summary>
    function ConvertReturnedElement(pIn: IRawElementProviderSimple; out ppRetValOut: IAccessibleEx): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IAccessibleEx}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationElement2 = interface(IUIAutomationElement)
  ['{6749C683-F70D-4487-A698-5F79D55290D6}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_currentoptimizeforvisualcontent</summary>
    function get_CurrentOptimizeForVisualContent(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_cachedoptimizeforvisualcontent</summary>
    function get_CachedOptimizeForVisualContent(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_currentlivesetting</summary>
    function get_CurrentLiveSetting(out retVal: LiveSetting): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_cachedlivesetting</summary>
    function get_CachedLiveSetting(out retVal: LiveSetting): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_currentflowsfrom</summary>
    function get_CurrentFlowsFrom(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_cachedflowsfrom</summary>
    function get_CachedFlowsFrom(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationElement2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement3</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.1</i></para>
  ///</remarks>
  IUIAutomationElement3 = interface(IUIAutomationElement2)
  ['{8471DF34-AEE0-4A01-A7DE-7DB9AF12C296}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement3-showcontextmenu</summary>
    function ShowContextMenu: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement3-get_currentisperipheral</summary>
    function get_CurrentIsPeripheral(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement3-get_cachedisperipheral</summary>
    function get_CachedIsPeripheral(out retVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationElement3}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement4</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.10240</i></para>
  ///</remarks>
  IUIAutomationElement4 = interface(IUIAutomationElement3)
  ['{3B6E233C-52FB-4063-A4C9-77C075C2A06B}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentpositioninset</summary>
    function get_CurrentPositionInSet(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentsizeofset</summary>
    function get_CurrentSizeOfSet(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentlevel</summary>
    function get_CurrentLevel(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentannotationtypes</summary>
    function get_CurrentAnnotationTypes(out retVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentannotationobjects</summary>
    function get_CurrentAnnotationObjects(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_cachedpositioninset</summary>
    function get_CachedPositionInSet(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_cachedsizeofset</summary>
    function get_CachedSizeOfSet(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_cachedlevel</summary>
    function get_CachedLevel(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_cachedannotationtypes</summary>
    function get_CachedAnnotationTypes(out retVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_cachedannotationobjects</summary>
    function get_CachedAnnotationObjects(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationElement4}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement5</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.15063</i></para>
  ///</remarks>
  IUIAutomationElement5 = interface(IUIAutomationElement4)
  ['{98141C1D-0D0E-4175-BBE2-6BFF455842A7}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement5-get_currentlandmarktype</summary>
    function get_CurrentLandmarkType(out retVal: UIA_LANDMARKTYPE_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement5-get_currentlocalizedlandmarktype</summary>
    function get_CurrentLocalizedLandmarkType(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement5-get_cachedlandmarktype</summary>
    function get_CachedLandmarkType(out retVal: UIA_LANDMARKTYPE_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement5-get_cachedlocalizedlandmarktype</summary>
    function get_CachedLocalizedLandmarkType(out retVal: PChar): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationElement5}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itextrangeprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  ITextRangeProvider = interface(IUnknown)
  ['{5347AD7B-C355-46F8-AFF5-909033582F63}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-clone</summary>
    function Clone(out pRetVal: ITextRangeProvider): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-compare</summary>
    function Compare(range: ITextRangeProvider; out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-compareendpoints</summary>
    function CompareEndpoints(endpoint: TextPatternRangeEndpoint; targetRange: ITextRangeProvider; targetEndpoint: TextPatternRangeEndpoint; out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-expandtoenclosingunit</summary>
    function ExpandToEnclosingUnit(&unit: TextUnit): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-findattribute</summary>
    function FindAttribute(attributeId: UIA_TEXTATTRIBUTE_ID; val: OleVariant; backward: BOOL; out pRetVal: ITextRangeProvider): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-findtext</summary>
    function FindText(text: PChar; backward: BOOL; ignoreCase: BOOL; out pRetVal: ITextRangeProvider): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-getattributevalue</summary>
    function GetAttributeValue(attributeId: UIA_TEXTATTRIBUTE_ID; out pRetVal: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-getboundingrectangles</summary>
    function GetBoundingRectangles(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-getenclosingelement</summary>
    function GetEnclosingElement(out pRetVal: IRawElementProviderSimple): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-gettext</summary>
    function GetText(maxLength: Integer; out pRetVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-move</summary>
    function Move(&unit: TextUnit; count: Integer; out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-moveendpointbyunit</summary>
    function MoveEndpointByUnit(endpoint: TextPatternRangeEndpoint; &unit: TextUnit; count: Integer; out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-moveendpointbyrange</summary>
    function MoveEndpointByRange(endpoint: TextPatternRangeEndpoint; targetRange: ITextRangeProvider; targetEndpoint: TextPatternRangeEndpoint): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-select</summary>
    function Select: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-addtoselection</summary>
    function AddToSelection: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-removefromselection</summary>
    function RemoveFromSelection: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-scrollintoview</summary>
    function ScrollIntoView(alignToTop: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-getchildren</summary>
    function GetChildren(out pRetVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITextRangeProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itextprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  ITextProvider = interface(IUnknown)
  ['{3589C92C-63F3-4367-99BB-ADA653B77CF2}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-getselection</summary>
    function GetSelection(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-getvisibleranges</summary>
    function GetVisibleRanges(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-rangefromchild</summary>
    function RangeFromChild(childElement: IRawElementProviderSimple; out pRetVal: ITextRangeProvider): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-rangefrompoint</summary>
    function RangeFromPoint(point: UiaPoint; out pRetVal: ITextRangeProvider): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-get_documentrange</summary>
    function get_DocumentRange(out pRetVal: ITextRangeProvider): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-get_supportedtextselection</summary>
    function get_SupportedTextSelection(out pRetVal: SupportedTextSelection): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITextProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itextprovider2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  ITextProvider2 = interface(ITextProvider)
  ['{0DC5E6ED-3E16-4BF1-8F9A-A979878BC195}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider2-rangefromannotation</summary>
    function RangeFromAnnotation(annotationElement: IRawElementProviderSimple; out pRetVal: ITextRangeProvider): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider2-getcaretrange</summary>
    function GetCaretRange(out isActive: BOOL; out pRetVal: ITextRangeProvider): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITextProvider2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationitemcontainerpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationItemContainerPattern = interface(IUnknown)
  ['{C690FDB2-27A8-423C-812D-429773C9084E}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationitemcontainerpattern-finditembyproperty</summary>
    function FindItemByProperty(pStartAfter: IUIAutomationElement; propertyId: UIA_PROPERTY_ID; value: OleVariant; out pFound: IUIAutomationElement): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationItemContainerPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itransformprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  ITransformProvider = interface(IUnknown)
  ['{6829DDC4-4F91-4FFA-B86F-BD3E2987CB4C}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-move</summary>
    function Move(x: Double; y: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-resize</summary>
    function Resize(width: Double; height: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-rotate</summary>
    function Rotate(degrees: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-get_canmove</summary>
    function get_CanMove(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-get_canresize</summary>
    function get_CanResize(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-get_canrotate</summary>
    function get_CanRotate(out pRetVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITransformProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itransformprovider2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  ITransformProvider2 = interface(ITransformProvider)
  ['{4758742F-7AC2-460C-BC48-09FC09308A93}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-zoom</summary>
    function Zoom(zoom: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-get_canzoom</summary>
    function get_CanZoom(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-get_zoomlevel</summary>
    function get_ZoomLevel(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-get_zoomminimum</summary>
    function get_ZoomMinimum(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-get_zoommaximum</summary>
    function get_ZoomMaximum(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-zoombyunit</summary>
    function ZoomByUnit(zoomUnit: ZoomUnit): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITransformProvider2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationdragpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationDragPattern = interface(IUnknown)
  ['{1DC7B570-1F54-4BAD-BCDA-D36A722FB7BD}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_currentisgrabbed</summary>
    function get_CurrentIsGrabbed(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_cachedisgrabbed</summary>
    function get_CachedIsGrabbed(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_currentdropeffect</summary>
    function get_CurrentDropEffect(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_cacheddropeffect</summary>
    function get_CachedDropEffect(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_currentdropeffects</summary>
    function get_CurrentDropEffects(out retVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_cacheddropeffects</summary>
    function get_CachedDropEffects(out retVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-getcurrentgrabbeditems</summary>
    function GetCurrentGrabbedItems(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-getcachedgrabbeditems</summary>
    function GetCachedGrabbedItems(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationDragPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iexpandcollapseprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IExpandCollapseProvider = interface(IUnknown)
  ['{D847D3A5-CAB0-4A98-8C32-ECB45C59AD24}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iexpandcollapseprovider-expand</summary>
    function Expand: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iexpandcollapseprovider-collapse</summary>
    function Collapse: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iexpandcollapseprovider-get_expandcollapsestate</summary>
    function get_ExpandCollapseState(out pRetVal: ExpandCollapseState): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IExpandCollapseProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationnotificationeventhandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.16299</i></para>
  ///</remarks>
  IUIAutomationNotificationEventHandler = interface(IUnknown)
  ['{C7CB2637-E6C2-4D0C-85DE-4948C02175C7}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationnotificationeventhandler-handlenotificationevent</summary>
    function HandleNotificationEvent(sender: IUIAutomationElement; notificationKind: NotificationKind; notificationProcessing: NotificationProcessing; displayString: PChar; activityId: PChar): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationNotificationEventHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iuiautomationpatterninstance</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationPatternInstance = interface(IUnknown)
  ['{C03A7FE4-9431-409F-BED8-AE7C2299BC8D}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationpatterninstance-getproperty</summary>
    function GetProperty(index: Cardinal; cached: BOOL; &type: UIAutomationType; out pPtr: Pointer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationpatterninstance-callmethod</summary>
    function CallMethod(index: Cardinal; pParams: PUIAutomationParameter; cParams: Cardinal): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationPatternInstance}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationscrollpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationScrollPattern = interface(IUnknown)
  ['{88F4D42A-E881-459D-A77C-73BBBB7E02DC}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-scroll</summary>
    function Scroll(horizontalAmount: ScrollAmount; verticalAmount: ScrollAmount): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-setscrollpercent</summary>
    function SetScrollPercent(horizontalPercent: Double; verticalPercent: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currenthorizontalscrollpercent</summary>
    function get_CurrentHorizontalScrollPercent(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currentverticalscrollpercent</summary>
    function get_CurrentVerticalScrollPercent(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currenthorizontalviewsize</summary>
    function get_CurrentHorizontalViewSize(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currentverticalviewsize</summary>
    function get_CurrentVerticalViewSize(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currenthorizontallyscrollable</summary>
    function get_CurrentHorizontallyScrollable(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currentverticallyscrollable</summary>
    function get_CurrentVerticallyScrollable(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedhorizontalscrollpercent</summary>
    function get_CachedHorizontalScrollPercent(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedverticalscrollpercent</summary>
    function get_CachedVerticalScrollPercent(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedhorizontalviewsize</summary>
    function get_CachedHorizontalViewSize(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedverticalviewsize</summary>
    function get_CachedVerticalViewSize(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedhorizontallyscrollable</summary>
    function get_CachedHorizontallyScrollable(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedverticallyscrollable</summary>
    function get_CachedVerticallyScrollable(out retVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationScrollPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementproviderhostingaccessibles</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IRawElementProviderHostingAccessibles = interface(IUnknown)
  ['{24BE0B07-D37D-487A-98CF-A13ED465E9B3}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderhostingaccessibles-getembeddedaccessibles</summary>
    function GetEmbeddedAccessibles(out pRetVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRawElementProviderHostingAccessibles}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement6</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.15063</i></para>
  ///</remarks>
  IUIAutomationElement6 = interface(IUIAutomationElement5)
  ['{4780D450-8BCA-4977-AFA5-A4A517F555E3}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement6-get_currentfulldescription</summary>
    function get_CurrentFullDescription(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement6-get_cachedfulldescription</summary>
    function get_CachedFullDescription(out retVal: PChar): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationElement6}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement7</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.15063</i></para>
  ///</remarks>
  IUIAutomationElement7 = interface(IUIAutomationElement6)
  ['{204E8572-CFC3-4C11-B0C8-7DA7420750B7}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-findfirstwithoptions</summary>
    function FindFirstWithOptions(scope: TreeScope; condition: IUIAutomationCondition; traversalOptions: TreeTraversalOptions; root: IUIAutomationElement; out found: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-findallwithoptions</summary>
    function FindAllWithOptions(scope: TreeScope; condition: IUIAutomationCondition; traversalOptions: TreeTraversalOptions; root: IUIAutomationElement; out found: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-findfirstwithoptionsbuildcache</summary>
    function FindFirstWithOptionsBuildCache(scope: TreeScope; condition: IUIAutomationCondition; cacheRequest: IUIAutomationCacheRequest; traversalOptions: TreeTraversalOptions; root: IUIAutomationElement; out found: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-findallwithoptionsbuildcache</summary>
    function FindAllWithOptionsBuildCache(scope: TreeScope; condition: IUIAutomationCondition; cacheRequest: IUIAutomationCacheRequest; traversalOptions: TreeTraversalOptions; root: IUIAutomationElement; out found: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-getcurrentmetadatavalue</summary>
    function GetCurrentMetadataValue(targetId: Integer; metadataId: UIA_METADATA_ID; out returnVal: OleVariant): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationElement7}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement8</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.17134</i></para>
  ///</remarks>
  IUIAutomationElement8 = interface(IUIAutomationElement7)
  ['{8C60217D-5411-4CDE-BCC0-1CEDA223830C}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement8-get_currentheadinglevel</summary>
    function get_CurrentHeadingLevel(out retVal: UIA_HEADINGLEVEL_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement8-get_cachedheadinglevel</summary>
    function get_CachedHeadingLevel(out retVal: UIA_HEADINGLEVEL_ID): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationElement8}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement9</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.17763</i></para>
  ///</remarks>
  IUIAutomationElement9 = interface(IUIAutomationElement8)
  ['{39325FAC-039D-440E-A3A3-5EB81A5CECC3}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement9-get_currentisdialog</summary>
    function get_CurrentIsDialog(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement9-get_cachedisdialog</summary>
    function get_CachedIsDialog(out retVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationElement9}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itoggleprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IToggleProvider = interface(IUnknown)
  ['{56D00BD0-C4F4-433C-A836-1A52A57E0892}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itoggleprovider-toggle</summary>
    function Toggle: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itoggleprovider-get_togglestate</summary>
    function get_ToggleState(out pRetVal: ToggleState): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IToggleProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrange2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.1</i></para>
  ///</remarks>
  IUIAutomationTextRange2 = interface(IUIAutomationTextRange)
  ['{BB9B40E0-5E04-46BD-9BE0-4B601B9AFAD4}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange2-showcontextmenu</summary>
    function ShowContextMenu: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTextRange2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrangearray</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationTextRangeArray = interface(IUnknown)
  ['{CE4AE76A-E717-4C98-81EA-47371D028EB6}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrangearray-get_length</summary>
    function get_Length(out length: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrangearray-getelement</summary>
    function GetElement(index: Integer; out element: IUIAutomationTextRange): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTextRangeArray}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomation2 = interface(IUIAutomation)
  ['{34723AFF-0C9D-49D0-9896-7AB52DF8CD8A}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-get_autosetfocus</summary>
    function get_AutoSetFocus(out autoSetFocus: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-put_autosetfocus</summary>
    function put_AutoSetFocus(autoSetFocus: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-get_connectiontimeout</summary>
    function get_ConnectionTimeout(out timeout: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-put_connectiontimeout</summary>
    function put_ConnectionTimeout(timeout: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-get_transactiontimeout</summary>
    function get_TransactionTimeout(out timeout: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-put_transactiontimeout</summary>
    function put_TransactionTimeout(timeout: Cardinal): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomation2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextedittextchangedeventhandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.1</i></para>
  ///</remarks>
  IUIAutomationTextEditTextChangedEventHandler = interface(IUnknown)
  ['{92FAA680-E704-4156-931A-E32D5BB38F3F}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextedittextchangedeventhandler-handletextedittextchangedevent</summary>
    function HandleTextEditTextChangedEvent(sender: IUIAutomationElement; textEditChangeType: TextEditChangeType; eventStrings: PSAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTextEditTextChangedEventHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation3</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.1</i></para>
  ///</remarks>
  IUIAutomation3 = interface(IUIAutomation2)
  ['{73D768DA-9B51-4B89-936E-C209290973E7}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation3-addtextedittextchangedeventhandler</summary>
    function AddTextEditTextChangedEventHandler(element: IUIAutomationElement; scope: TreeScope; textEditChangeType: TextEditChangeType; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationTextEditTextChangedEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation3-removetextedittextchangedeventhandler</summary>
    function RemoveTextEditTextChangedEventHandler(element: IUIAutomationElement; handler: IUIAutomationTextEditTextChangedEventHandler): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomation3}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationchangeseventhandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.15063</i></para>
  ///</remarks>
  IUIAutomationChangesEventHandler = interface(IUnknown)
  ['{58EDCA55-2C3E-4980-B1B9-56C17F27A2A0}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationchangeseventhandler-handlechangesevent</summary>
    function HandleChangesEvent(sender: IUIAutomationElement; uiaChanges: PUiaChangeInfo; changesCount: Integer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationChangesEventHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation4</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.14393</i></para>
  ///</remarks>
  IUIAutomation4 = interface(IUIAutomation3)
  ['{1189C02A-05F8-4319-8E21-E817E3DB2860}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation4-addchangeseventhandler</summary>
    function AddChangesEventHandler(element: IUIAutomationElement; scope: TreeScope; changeTypes: PInteger; changesCount: Integer; pCacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationChangesEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation4-removechangeseventhandler</summary>
    function RemoveChangesEventHandler(element: IUIAutomationElement; handler: IUIAutomationChangesEventHandler): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomation4}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation5</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.14393</i></para>
  ///</remarks>
  IUIAutomation5 = interface(IUIAutomation4)
  ['{25F700C8-D816-4057-A9DC-3CBDEE77E256}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation5-addnotificationeventhandler</summary>
    function AddNotificationEventHandler(element: IUIAutomationElement; scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationNotificationEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation5-removenotificationeventhandler</summary>
    function RemoveNotificationEventHandler(element: IUIAutomationElement; handler: IUIAutomationNotificationEventHandler): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomation5}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationTextPattern = interface(IUnknown)
  ['{32EBA289-3583-42C9-9C59-3B6D9A1E9B6A}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-rangefrompoint</summary>
    function RangeFromPoint(pt: TPointF; out range: IUIAutomationTextRange): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-rangefromchild</summary>
    function RangeFromChild(child: IUIAutomationElement; out range: IUIAutomationTextRange): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-getselection</summary>
    function GetSelection(out ranges: IUIAutomationTextRangeArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-getvisibleranges</summary>
    function GetVisibleRanges(out ranges: IUIAutomationTextRangeArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-get_documentrange</summary>
    function get_DocumentRange(out range: IUIAutomationTextRange): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-get_supportedtextselection</summary>
    function get_SupportedTextSelection(out supportedTextSelection: SupportedTextSelection): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTextPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtransformpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationTransformPattern = interface(IUnknown)
  ['{A9B55844-A55D-4EF0-926D-569C16FF89BB}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-move</summary>
    function Move(x: Double; y: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-resize</summary>
    function Resize(width: Double; height: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-rotate</summary>
    function Rotate(degrees: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanmove</summary>
    function get_CurrentCanMove(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanresize</summary>
    function get_CurrentCanResize(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanrotate</summary>
    function get_CurrentCanRotate(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_cachedcanmove</summary>
    function get_CachedCanMove(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_cachedcanresize</summary>
    function get_CachedCanResize(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_cachedcanrotate</summary>
    function get_CachedCanRotate(out retVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTransformPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextpattern2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationTextPattern2 = interface(IUIAutomationTextPattern)
  ['{506A921A-FCC9-409F-B23B-37EB74106872}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern2-rangefromannotation</summary>
    function RangeFromAnnotation(annotation: IUIAutomationElement; out range: IUIAutomationTextRange): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern2-getcaretrange</summary>
    function GetCaretRange(out isActive: BOOL; out range: IUIAutomationTextRange): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTextPattern2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-ivalueprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IValueProvider = interface(IUnknown)
  ['{C7935180-6FB3-4201-B174-7DF73ADBF64A}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ivalueprovider-setvalue</summary>
    function SetValue(val: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ivalueprovider-get_value</summary>
    function get_Value(out pRetVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ivalueprovider-get_isreadonly</summary>
    function get_IsReadOnly(out pRetVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IValueProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationactivetextpositionchangedeventhandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.17763</i></para>
  ///</remarks>
  IUIAutomationActiveTextPositionChangedEventHandler = interface(IUnknown)
  ['{F97933B0-8DAE-4496-8997-5BA015FE0D82}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationactivetextpositionchangedeventhandler-handleactivetextpositionchangedevent</summary>
    function HandleActiveTextPositionChangedEvent(sender: IUIAutomationElement; range: IUIAutomationTextRange): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationActiveTextPositionChangedEventHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationeventhandlergroup</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.17763</i></para>
  ///</remarks>
  IUIAutomationEventHandlerGroup = interface(IUnknown)
  ['{C9EE12F2-C13B-4408-997C-639914377F4E}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addactivetextpositionchangedeventhandler</summary>
    function AddActiveTextPositionChangedEventHandler(scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationActiveTextPositionChangedEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addautomationeventhandler</summary>
    function AddAutomationEventHandler(eventId: UIA_EVENT_ID; scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addchangeseventhandler</summary>
    function AddChangesEventHandler(scope: TreeScope; changeTypes: PInteger; changesCount: Integer; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationChangesEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addnotificationeventhandler</summary>
    function AddNotificationEventHandler(scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationNotificationEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addpropertychangedeventhandler</summary>
    function AddPropertyChangedEventHandler(scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationPropertyChangedEventHandler; propertyArray: PUIA_PROPERTY_ID; propertyCount: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addstructurechangedeventhandler</summary>
    function AddStructureChangedEventHandler(scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationStructureChangedEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addtextedittextchangedeventhandler</summary>
    function AddTextEditTextChangedEventHandler(scope: TreeScope; textEditChangeType: TextEditChangeType; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationTextEditTextChangedEventHandler): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationEventHandlerGroup}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationmultipleviewpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationMultipleViewPattern = interface(IUnknown)
  ['{8D253C91-1DC5-4BB5-B18F-ADE16FA495E8}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-getviewname</summary>
    function GetViewName(view: Integer; out name: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-setcurrentview</summary>
    function SetCurrentView(view: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-get_currentcurrentview</summary>
    function get_CurrentCurrentView(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-getcurrentsupportedviews</summary>
    function GetCurrentSupportedViews(out retVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-get_cachedcurrentview</summary>
    function get_CachedCurrentView(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-getcachedsupportedviews</summary>
    function GetCachedSupportedViews(out retVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationMultipleViewPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationscrollitempattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationScrollItemPattern = interface(IUnknown)
  ['{B488300F-D015-4F19-9C29-BB595E3645EF}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollitempattern-scrollintoview</summary>
    function ScrollIntoView: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationScrollItemPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-imultipleviewprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IMultipleViewProvider = interface(IUnknown)
  ['{6278CAB1-B556-4A1A-B4E0-418ACC523201}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-imultipleviewprovider-getviewname</summary>
    function GetViewName(viewId: Integer; out pRetVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-imultipleviewprovider-setcurrentview</summary>
    function SetCurrentView(viewId: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-imultipleviewprovider-get_currentview</summary>
    function get_CurrentView(out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-imultipleviewprovider-getsupportedviews</summary>
    function GetSupportedViews(out pRetVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IMultipleViewProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iwindowprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IWindowProvider = interface(IUnknown)
  ['{987DF77B-DB06-4D77-8F8A-86A9C3BB90B9}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-setvisualstate</summary>
    function SetVisualState(state: WindowVisualState): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-close</summary>
    function Close: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-waitforinputidle</summary>
    function WaitForInputIdle(milliseconds: Integer; out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_canmaximize</summary>
    function get_CanMaximize(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_canminimize</summary>
    function get_CanMinimize(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_ismodal</summary>
    function get_IsModal(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_windowvisualstate</summary>
    function get_WindowVisualState(out pRetVal: WindowVisualState): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_windowinteractionstate</summary>
    function get_WindowInteractionState(out pRetVal: WindowInteractionState): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_istopmost</summary>
    function get_IsTopmost(out pRetVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IWindowProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementproviderfragmentroot</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IRawElementProviderFragmentRoot = interface(IUnknown)
  ['{620CE2A5-AB8F-40A9-86CB-DE3C75599B58}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragmentroot-elementproviderfrompoint</summary>
    function ElementProviderFromPoint(x: Double; y: Double; out pRetVal: IRawElementProviderFragment): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragmentroot-getfocus</summary>
    function GetFocus(out pRetVal: IRawElementProviderFragment): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRawElementProviderFragmentRoot}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementproviderfragment</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IRawElementProviderFragment = interface(IUnknown)
  ['{F7063DA8-8359-439C-9297-BBC5299A7D87}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-navigate</summary>
    function Navigate(direction: NavigateDirection; out pRetVal: IRawElementProviderFragment): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-getruntimeid</summary>
    function GetRuntimeId(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-get_boundingrectangle</summary>
    function get_BoundingRectangle(out pRetVal: UiaRect): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-getembeddedfragmentroots</summary>
    function GetEmbeddedFragmentRoots(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-setfocus</summary>
    function SetFocus: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-get_fragmentroot</summary>
    function get_FragmentRoot(out pRetVal: IRawElementProviderFragmentRoot): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRawElementProviderFragment}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irangevalueprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IRangeValueProvider = interface(IUnknown)
  ['{36DC7AEF-33E6-4691-AFE1-2BE7274B3D33}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-setvalue</summary>
    function SetValue(val: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_value</summary>
    function get_Value(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_isreadonly</summary>
    function get_IsReadOnly(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_maximum</summary>
    function get_Maximum(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_minimum</summary>
    function get_Minimum(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_largechange</summary>
    function get_LargeChange(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_smallchange</summary>
    function get_SmallChange(out pRetVal: Double): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRangeValueProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iitemcontainerprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IItemContainerProvider = interface(IUnknown)
  ['{E747770B-39CE-4382-AB30-D8FB3F336F24}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iitemcontainerprovider-finditembyproperty</summary>
    function FindItemByProperty(pStartAfter: IRawElementProviderSimple; propertyId: UIA_PROPERTY_ID; value: OleVariant; out pFound: IRawElementProviderSimple): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IItemContainerProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-istylesprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IStylesProvider = interface(IUnknown)
  ['{19B6B649-F5D7-4A6D-BDCB-129252BE588A}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_styleid</summary>
    function get_StyleId(out retVal: UIA_STYLE_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_stylename</summary>
    function get_StyleName(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_fillcolor</summary>
    function get_FillColor(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_fillpatternstyle</summary>
    function get_FillPatternStyle(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_shape</summary>
    function get_Shape(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_fillpatterncolor</summary>
    function get_FillPatternColor(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_extendedproperties</summary>
    function get_ExtendedProperties(out retVal: PChar): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IStylesProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iinvokeprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IInvokeProvider = interface(IUnknown)
  ['{54FCB24B-E18E-47A2-B4D3-ECCBE77599A2}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iinvokeprovider-invoke</summary>
    function Invoke: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IInvokeProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationexpandcollapsepattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationExpandCollapsePattern = interface(IUnknown)
  ['{619BE086-1F4E-4EE4-BAFA-210128738730}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-expand</summary>
    function Expand: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-collapse</summary>
    function Collapse: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-get_currentexpandcollapsestate</summary>
    function get_CurrentExpandCollapseState(out retVal: ExpandCollapseState): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-get_cachedexpandcollapsestate</summary>
    function get_CachedExpandCollapseState(out retVal: ExpandCollapseState): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationExpandCollapsePattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementproviderwindowlesssite</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IRawElementProviderWindowlessSite = interface(IUnknown)
  ['{0A2A93CC-BFAD-42AC-9B2E-0991FB0D3EA0}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderwindowlesssite-getadjacentfragment</summary>
    function GetAdjacentFragment(direction: NavigateDirection; out ppParent: IRawElementProviderFragment): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderwindowlesssite-getruntimeidprefix</summary>
    function GetRuntimeIdPrefix(out pRetVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRawElementProviderWindowlessSite}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/textserv/nn-textserv-iricheditwindowlessaccessibility</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IRicheditWindowlessAccessibility = interface(IUnknown)
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/textserv/nf-textserv-iricheditwindowlessaccessibility-createprovider</summary>
    function CreateProvider(pSite: IRawElementProviderWindowlessSite; out ppProvider: IRawElementProviderSimple): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRicheditWindowlessAccessibility}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-ivirtualizeditemprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IVirtualizedItemProvider = interface(IUnknown)
  ['{CB98B665-2D35-4FAC-AD35-F3C60D0C0B8B}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ivirtualizeditemprovider-realize</summary>
    function Realize: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IVirtualizedItemProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iselectionprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  ISelectionProvider = interface(IUnknown)
  ['{FB8B03AF-3BDF-48D4-BD36-1A65793BE168}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider-getselection</summary>
    function GetSelection(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider-get_canselectmultiple</summary>
    function get_CanSelectMultiple(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider-get_isselectionrequired</summary>
    function get_IsSelectionRequired(out pRetVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISelectionProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iselectionprovider2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.16299</i></para>
  ///</remarks>
  ISelectionProvider2 = interface(ISelectionProvider)
  ['{14F68475-EE1C-44F6-A869-D239381F0FE7}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider2-get_firstselecteditem</summary>
    function get_FirstSelectedItem(out retVal: IRawElementProviderSimple): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider2-get_lastselecteditem</summary>
    function get_LastSelectedItem(out retVal: IRawElementProviderSimple): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider2-get_currentselecteditem</summary>
    function get_CurrentSelectedItem(out retVal: IRawElementProviderSimple): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider2-get_itemcount</summary>
    function get_ItemCount(out retVal: Integer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISelectionProvider2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iaccessiblehostingelementproviders</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IAccessibleHostingElementProviders = interface(IUnknown)
  ['{33AC331B-943E-4020-B295-DB37784974A3}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessiblehostingelementproviders-getembeddedfragmentroots</summary>
    function GetEmbeddedFragmentRoots(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessiblehostingelementproviders-getobjectidforprovider</summary>
    function GetObjectIdForProvider(pProvider: IRawElementProviderSimple; out pidObject: Integer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IAccessibleHostingElementProviders}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-idockprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IDockProvider = interface(IUnknown)
  ['{159BC72C-4AD3-485E-9637-D7052EDF0146}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idockprovider-setdockposition</summary>
    function SetDockPosition(dockPosition: DockPosition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idockprovider-get_dockposition</summary>
    function get_DockPosition(out pRetVal: DockPosition): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDockProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationselectionitempattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationSelectionItemPattern = interface(IUnknown)
  ['{A8EFA66A-0FDA-421A-9194-38021F3578EA}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-select</summary>
    function Select: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-addtoselection</summary>
    function AddToSelection: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-removefromselection</summary>
    function RemoveFromSelection: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-get_currentisselected</summary>
    function get_CurrentIsSelected(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-get_currentselectioncontainer</summary>
    function get_CurrentSelectionContainer(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-get_cachedisselected</summary>
    function get_CachedIsSelected(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-get_cachedselectioncontainer</summary>
    function get_CachedSelectionContainer(out retVal: IUIAutomationElement): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationSelectionItemPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementprovidersimple2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.1</i></para>
  ///</remarks>
  IRawElementProviderSimple2 = interface(IRawElementProviderSimple)
  ['{A0A839A9-8DA1-4A82-806A-8E0D44E79F56}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple2-showcontextmenu</summary>
    function ShowContextMenu: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRawElementProviderSimple2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementprovidersimple3</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.15063</i></para>
  ///</remarks>
  IRawElementProviderSimple3 = interface(IRawElementProviderSimple2)
  ['{FCF5D820-D7EC-4613-BDF6-42A84CE7DAAF}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple3-getmetadatavalue</summary>
    function GetMetadataValue(targetId: Integer; metadataId: UIA_METADATA_ID; out returnVal: OleVariant): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRawElementProviderSimple3}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iscrollitemprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IScrollItemProvider = interface(IUnknown)
  ['{2360C714-4BF1-4B26-BA65-9B21316127EB}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollitemprovider-scrollintoview</summary>
    function ScrollIntoView: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IScrollItemProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-isynchronizedinputprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  ISynchronizedInputProvider = interface(IUnknown)
  ['{29DB1A06-02CE-4CF7-9B42-565D4FAB20EE}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-isynchronizedinputprovider-startlistening</summary>
    function StartListening(inputType: SynchronizedInputType): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-isynchronizedinputprovider-cancel</summary>
    function Cancel: HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISynchronizedInputProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationcustomnavigationpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.10240</i></para>
  ///</remarks>
  IUIAutomationCustomNavigationPattern = interface(IUnknown)
  ['{01EA217A-1766-47ED-A6CC-ACF492854B1F}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcustomnavigationpattern-navigate</summary>
    function Navigate(direction: NavigateDirection; out pRetVal: IUIAutomationElement): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationCustomNavigationPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationboolcondition</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationBoolCondition = interface(IUIAutomationCondition)
  ['{1B4E1F2E-75EB-4D0B-8952-5A69988E2307}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationboolcondition-get_booleanvalue</summary>
    function get_BooleanValue(out boolVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationBoolCondition}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementprovideradviseevents</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IRawElementProviderAdviseEvents = interface(IUnknown)
  ['{A407B27B-0F6D-4427-9292-473C7BF93258}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovideradviseevents-adviseeventadded</summary>
    function AdviseEventAdded(eventId: UIA_EVENT_ID; propertyIDs: PSAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovideradviseevents-adviseeventremoved</summary>
    function AdviseEventRemoved(eventId: UIA_EVENT_ID; propertyIDs: PSAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRawElementProviderAdviseEvents}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementproviderhwndoverride</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IRawElementProviderHwndOverride = interface(IUnknown)
  ['{1D5DF27C-8947-4425-B8D9-79787BB460B8}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderhwndoverride-getoverrideproviderforhwnd</summary>
    function GetOverrideProviderForHwnd(hwnd: HWND; out pRetVal: IRawElementProviderSimple): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRawElementProviderHwndOverride}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itableprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  ITableProvider = interface(IUnknown)
  ['{9C860395-97B3-490A-B52A-858CC22AF166}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itableprovider-getrowheaders</summary>
    function GetRowHeaders(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itableprovider-getcolumnheaders</summary>
    function GetColumnHeaders(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itableprovider-get_roworcolumnmajor</summary>
    function get_RowOrColumnMajor(out pRetVal: RowOrColumnMajor): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITableProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-ispreadsheetitemprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  ISpreadsheetItemProvider = interface(IUnknown)
  ['{EAED4660-7B3D-4879-A2E6-365CE603F3D0}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ispreadsheetitemprovider-get_formula</summary>
    function get_Formula(out pRetVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ispreadsheetitemprovider-getannotationobjects</summary>
    function GetAnnotationObjects(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ispreadsheetitemprovider-getannotationtypes</summary>
    function GetAnnotationTypes(out pRetVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISpreadsheetItemProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iproxyproviderwineventsink</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IProxyProviderWinEventSink = interface(IUnknown)
  ['{4FD82B78-A43E-46AC-9803-0A6969C7C183}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iproxyproviderwineventsink-addautomationpropertychangedevent</summary>
    function AddAutomationPropertyChangedEvent(pProvider: IRawElementProviderSimple; id: UIA_PROPERTY_ID; newValue: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iproxyproviderwineventsink-addautomationevent</summary>
    function AddAutomationEvent(pProvider: IRawElementProviderSimple; id: UIA_EVENT_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iproxyproviderwineventsink-addstructurechangedevent</summary>
    function AddStructureChangedEvent(pProvider: IRawElementProviderSimple; structureChangeType: StructureChangeType; runtimeId: PSAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IProxyProviderWinEventSink}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iobjectmodelprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IObjectModelProvider = interface(IUnknown)
  ['{3AD86EBD-F5EF-483D-BB18-B1042A475D64}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iobjectmodelprovider-getunderlyingobjectmodel</summary>
    function GetUnderlyingObjectModel(out ppUnknown: IUnknown): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IObjectModelProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationorcondition</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationOrCondition = interface(IUIAutomationCondition)
  ['{8753F032-3DB1-47B5-A1FC-6E34A266C712}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationorcondition-get_childcount</summary>
    function get_ChildCount(out childCount: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationorcondition-getchildrenasnativearray</summary>
    function GetChildrenAsNativeArray(out childArray: IUIAutomationCondition; out childArrayCount: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationorcondition-getchildren</summary>
    function GetChildren(out childArray: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationOrCondition}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationvaluepattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationValuePattern = interface(IUnknown)
  ['{A94CD8B1-0844-4CD6-9D2D-640537AB39E9}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-setvalue</summary>
    function SetValue(val: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-get_currentvalue</summary>
    function get_CurrentValue(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-get_currentisreadonly</summary>
    function get_CurrentIsReadOnly(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-get_cachedvalue</summary>
    function get_CachedValue(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-get_cachedisreadonly</summary>
    function get_CachedIsReadOnly(out retVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationValuePattern}

  ICustomNavigationProvider = interface(IUnknown)
  ['{2062A28A-8C07-4B94-8E12-7037C622AEB8}']
    function Navigate(direction: NavigateDirection; out pRetVal: IRawElementProviderSimple): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ICustomNavigationProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-igridprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IGridProvider = interface(IUnknown)
  ['{B17D6187-0907-464B-A168-0EF17A1572B1}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igridprovider-getitem</summary>
    function GetItem(row: Integer; column: Integer; out pRetVal: IRawElementProviderSimple): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igridprovider-get_rowcount</summary>
    function get_RowCount(out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igridprovider-get_columncount</summary>
    function get_ColumnCount(out pRetVal: Integer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IGridProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtexteditpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.1</i></para>
  ///</remarks>
  IUIAutomationTextEditPattern = interface(IUIAutomationTextPattern)
  ['{17E21576-996C-4870-99D9-BFF323380C06}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtexteditpattern-getactivecomposition</summary>
    function GetActiveComposition(out range: IUIAutomationTextRange): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtexteditpattern-getconversiontarget</summary>
    function GetConversionTarget(out range: IUIAutomationTextRange): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTextEditPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationannotationpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationAnnotationPattern = interface(IUnknown)
  ['{9A175B21-339E-41B1-8E8B-623F6B681098}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentannotationtypeid</summary>
    function get_CurrentAnnotationTypeId(out retVal: UIA_ANNOTATIONTYPE): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentannotationtypename</summary>
    function get_CurrentAnnotationTypeName(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentauthor</summary>
    function get_CurrentAuthor(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentdatetime</summary>
    function get_CurrentDateTime(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currenttarget</summary>
    function get_CurrentTarget(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_cachedannotationtypeid</summary>
    function get_CachedAnnotationTypeId(out retVal: UIA_ANNOTATIONTYPE): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_cachedannotationtypename</summary>
    function get_CachedAnnotationTypeName(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_cachedauthor</summary>
    function get_CachedAuthor(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_cacheddatetime</summary>
    function get_CachedDateTime(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_cachedtarget</summary>
    function get_CachedTarget(out retVal: IUIAutomationElement): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationAnnotationPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationandcondition</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationAndCondition = interface(IUIAutomationCondition)
  ['{A7D0AF36-B912-45FE-9855-091DDC174AEC}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationandcondition-get_childcount</summary>
    function get_ChildCount(out childCount: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationandcondition-getchildrenasnativearray</summary>
    function GetChildrenAsNativeArray(out childArray: IUIAutomationCondition; out childArrayCount: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationandcondition-getchildren</summary>
    function GetChildren(out childArray: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationAndCondition}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtablepattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationTablePattern = interface(IUnknown)
  ['{620E691C-EA96-4710-A850-754B24CE2417}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-getcurrentrowheaders</summary>
    function GetCurrentRowHeaders(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-getcurrentcolumnheaders</summary>
    function GetCurrentColumnHeaders(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-get_currentroworcolumnmajor</summary>
    function get_CurrentRowOrColumnMajor(out retVal: RowOrColumnMajor): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-getcachedrowheaders</summary>
    function GetCachedRowHeaders(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-getcachedcolumnheaders</summary>
    function GetCachedColumnHeaders(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-get_cachedroworcolumnmajor</summary>
    function get_CachedRowOrColumnMajor(out retVal: RowOrColumnMajor): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTablePattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationstylespattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationStylesPattern = interface(IUnknown)
  ['{85B5F0A2-BD79-484A-AD2B-388C9838D5FB}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentstyleid</summary>
    function get_CurrentStyleId(out retVal: UIA_STYLE_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentstylename</summary>
    function get_CurrentStyleName(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentfillcolor</summary>
    function get_CurrentFillColor(out retVal: Integer): HRESULT; stdcall;
    function get_CurrentFillPatternStyle(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentshape</summary>
    function get_CurrentShape(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentfillpatterncolor</summary>
    function get_CurrentFillPatternColor(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentextendedproperties</summary>
    function get_CurrentExtendedProperties(out retVal: PChar): HRESULT; stdcall;
    function GetCurrentExtendedPropertiesAsArray(out propertyArray: ExtendedProperty; out propertyCount: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedstyleid</summary>
    function get_CachedStyleId(out retVal: UIA_STYLE_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedstylename</summary>
    function get_CachedStyleName(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedfillcolor</summary>
    function get_CachedFillColor(out retVal: Integer): HRESULT; stdcall;
    function get_CachedFillPatternStyle(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedshape</summary>
    function get_CachedShape(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedfillpatterncolor</summary>
    function get_CachedFillPatternColor(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedextendedproperties</summary>
    function get_CachedExtendedProperties(out retVal: PChar): HRESULT; stdcall;
    function GetCachedExtendedPropertiesAsArray(out propertyArray: ExtendedProperty; out propertyCount: Integer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationStylesPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationgriditempattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationGridItemPattern = interface(IUnknown)
  ['{78F8EF57-66C3-4E09-BD7C-E79B2004894D}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentcontaininggrid</summary>
    function get_CurrentContainingGrid(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentrow</summary>
    function get_CurrentRow(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentcolumn</summary>
    function get_CurrentColumn(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentrowspan</summary>
    function get_CurrentRowSpan(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentcolumnspan</summary>
    function get_CurrentColumnSpan(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_cachedcontaininggrid</summary>
    function get_CachedContainingGrid(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_cachedrow</summary>
    function get_CachedRow(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_cachedcolumn</summary>
    function get_CachedColumn(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_cachedrowspan</summary>
    function get_CachedRowSpan(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_cachedcolumnspan</summary>
    function get_CachedColumnSpan(out retVal: Integer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationGridItemPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iannotationprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IAnnotationProvider = interface(IUnknown)
  ['{F95C7E80-BD63-4601-9782-445EBFF011FC}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iannotationprovider-get_annotationtypeid</summary>
    function get_AnnotationTypeId(out retVal: UIA_ANNOTATIONTYPE): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iannotationprovider-get_annotationtypename</summary>
    function get_AnnotationTypeName(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iannotationprovider-get_author</summary>
    function get_Author(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iannotationprovider-get_datetime</summary>
    function get_DateTime(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iannotationprovider-get_target</summary>
    function get_Target(out retVal: IRawElementProviderSimple): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IAnnotationProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationspreadsheetitempattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationSpreadsheetItemPattern = interface(IUnknown)
  ['{7D4FB86C-8D34-40E1-8E83-62C15204E335}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-get_currentformula</summary>
    function get_CurrentFormula(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-getcurrentannotationobjects</summary>
    function GetCurrentAnnotationObjects(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-getcurrentannotationtypes</summary>
    function GetCurrentAnnotationTypes(out retVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-get_cachedformula</summary>
    function get_CachedFormula(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-getcachedannotationobjects</summary>
    function GetCachedAnnotationObjects(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-getcachedannotationtypes</summary>
    function GetCachedAnnotationTypes(out retVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationSpreadsheetItemPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/textserv/nn-textserv-irichedituiainformation</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IRichEditUiaInformation = interface(IUnknown)
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/textserv/nf-textserv-irichedituiainformation-getboundaryrectangle</summary>
    function GetBoundaryRectangle(var pUiaRect: UiaRect): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/textserv/nf-textserv-irichedituiainformation-isvisible</summary>
    function IsVisible: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRichEditUiaInformation}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iproxyproviderwineventhandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IProxyProviderWinEventHandler = interface(IUnknown)
  ['{89592AD4-F4E0-43D5-A3B6-BAD7E111B435}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iproxyproviderwineventhandler-respondtowinevent</summary>
    function RespondToWinEvent(idWinEvent: Cardinal; hwnd: HWND; idObject: Integer; idChild: Integer; pSink: IProxyProviderWinEventSink): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IProxyProviderWinEventHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccpropserver</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IAccPropServer = interface(IUnknown)
  ['{76C0DBBB-15E0-4E7B-B61B-20EEEA2001E0}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropserver-getpropvalue</summary>
    function GetPropValue(pIDString: PByte; dwIDStringLen: Cardinal; idProp: TGuid; out pvarValue: OleVariant; out pfHasProp: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IAccPropServer}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrange3</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.15063</i></para>
  ///</remarks>
  IUIAutomationTextRange3 = interface(IUIAutomationTextRange2)
  ['{6A315D69-5512-4C2E-85F0-53FCE6DD4BC2}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange3-getenclosingelementbuildcache</summary>
    function GetEnclosingElementBuildCache(cacheRequest: IUIAutomationCacheRequest; out enclosingElement: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange3-getchildrenbuildcache</summary>
    function GetChildrenBuildCache(cacheRequest: IUIAutomationCacheRequest; out children: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange3-getattributevalues</summary>
    function GetAttributeValues(attributeIds: PUIA_TEXTATTRIBUTE_ID; attributeIdCount: Integer; out attributeValues: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTextRange3}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationselectionpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationSelectionPattern = interface(IUnknown)
  ['{5ED5202E-B2AC-47A6-B638-4B0BF140D78E}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-getcurrentselection</summary>
    function GetCurrentSelection(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_currentcanselectmultiple</summary>
    function get_CurrentCanSelectMultiple(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_currentisselectionrequired</summary>
    function get_CurrentIsSelectionRequired(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-getcachedselection</summary>
    function GetCachedSelection(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_cachedcanselectmultiple</summary>
    function get_CachedCanSelectMultiple(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_cachedisselectionrequired</summary>
    function get_CachedIsSelectionRequired(out retVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationSelectionPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationselectionpattern2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.16299</i></para>
  ///</remarks>
  IUIAutomationSelectionPattern2 = interface(IUIAutomationSelectionPattern)
  ['{0532BFAE-C011-4E32-A343-6D642D798555}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentfirstselecteditem</summary>
    function get_CurrentFirstSelectedItem(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentlastselecteditem</summary>
    function get_CurrentLastSelectedItem(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentcurrentselecteditem</summary>
    function get_CurrentCurrentSelectedItem(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentitemcount</summary>
    function get_CurrentItemCount(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_cachedfirstselecteditem</summary>
    function get_CachedFirstSelectedItem(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_cachedlastselecteditem</summary>
    function get_CachedLastSelectedItem(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_cachedcurrentselecteditem</summary>
    function get_CachedCurrentSelectedItem(out retVal: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_cacheditemcount</summary>
    function get_CachedItemCount(out retVal: Integer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationSelectionPattern2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationsynchronizedinputpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationSynchronizedInputPattern = interface(IUnknown)
  ['{2233BE0B-AFB7-448B-9FDA-3B378AA5EAE1}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationsynchronizedinputpattern-startlistening</summary>
    function StartListening(inputType: SynchronizedInputType): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationsynchronizedinputpattern-cancel</summary>
    function Cancel: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationSynchronizedInputPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itextrangeprovider2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.1</i></para>
  ///</remarks>
  ITextRangeProvider2 = interface(ITextRangeProvider)
  ['{9BBCE42C-1921-4F18-89CA-DBA1910A0386}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider2-showcontextmenu</summary>
    function ShowContextMenu: HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITextRangeProvider2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation6</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows10.0.17763</i></para>
  ///</remarks>
  IUIAutomation6 = interface(IUIAutomation5)
  ['{AAE072DA-29E3-413D-87A7-192DBF81ED10}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation6-createeventhandlergroup</summary>
    function CreateEventHandlerGroup(out handlerGroup: IUIAutomationEventHandlerGroup): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation6-addeventhandlergroup</summary>
    function AddEventHandlerGroup(element: IUIAutomationElement; handlerGroup: IUIAutomationEventHandlerGroup): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation6-removeeventhandlergroup</summary>
    function RemoveEventHandlerGroup(element: IUIAutomationElement; handlerGroup: IUIAutomationEventHandlerGroup): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation6-get_connectionrecoverybehavior</summary>
    function get_ConnectionRecoveryBehavior(out connectionRecoveryBehaviorOptions: ConnectionRecoveryBehaviorOptions): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation6-put_connectionrecoverybehavior</summary>
    function put_ConnectionRecoveryBehavior(connectionRecoveryBehaviorOptions: ConnectionRecoveryBehaviorOptions): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation6-get_coalesceevents</summary>
    function get_CoalesceEvents(out coalesceEventsOptions: CoalesceEventsOptions): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation6-put_coalesceevents</summary>
    function put_CoalesceEvents(coalesceEventsOptions: CoalesceEventsOptions): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation6-addactivetextpositionchangedeventhandler</summary>
    function AddActiveTextPositionChangedEventHandler(element: IUIAutomationElement; scope: TreeScope; cacheRequest: IUIAutomationCacheRequest; handler: IUIAutomationActiveTextPositionChangedEventHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation6-removeactivetextpositionchangedeventhandler</summary>
    function RemoveActiveTextPositionChangedEventHandler(element: IUIAutomationElement; handler: IUIAutomationActiveTextPositionChangedEventHandler): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomation6}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itableitemprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  ITableItemProvider = interface(IUnknown)
  ['{B9734FA6-771F-4D78-9C90-2517999349CD}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itableitemprovider-getrowheaderitems</summary>
    function GetRowHeaderItems(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itableitemprovider-getcolumnheaderitems</summary>
    function GetColumnHeaderItems(out pRetVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITableItemProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccessiblehandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IAccessibleHandler = interface(IUnknown)
  ['{03022430-ABC4-11D0-BDE2-00AA001A1953}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessiblehandler-accessibleobjectfromid</summary>
    function AccessibleObjectFromID(hwnd: Integer; lObjectID: Integer; out pIAccessible: IAccessible): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IAccessibleHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccessiblewindowlesssite</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IAccessibleWindowlessSite = interface(IUnknown)
  ['{BF3ABD9C-76DA-4389-9EB6-1427D25ABAB7}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessiblewindowlesssite-acquireobjectidrange</summary>
    function AcquireObjectIdRange(rangeSize: Integer; pRangeOwner: IAccessibleHandler; out pRangeBase: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessiblewindowlesssite-releaseobjectidrange</summary>
    function ReleaseObjectIdRange(rangeBase: Integer; pRangeOwner: IAccessibleHandler): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessiblewindowlesssite-queryobjectidranges</summary>
    function QueryObjectIdRanges(pRangesOwner: IAccessibleHandler; out psaRanges: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessiblewindowlesssite-getparentaccessible</summary>
    function GetParentAccessible(out ppParent: IAccessible): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IAccessibleWindowlessSite}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-ilegacyiaccessibleprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  ILegacyIAccessibleProvider = interface(IUnknown)
  ['{E44C3566-915D-4070-99C6-047BFF5A08F5}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-select</summary>
    function Select(flagsSelect: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-dodefaultaction</summary>
    function DoDefaultAction: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-setvalue</summary>
    function SetValue(szValue: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-getiaccessible</summary>
    function GetIAccessible(out ppAccessible: IAccessible): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_childid</summary>
    function get_ChildId(out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_name</summary>
    function get_Name(out pszName: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_value</summary>
    function get_Value(out pszValue: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_description</summary>
    function get_Description(out pszDescription: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_role</summary>
    function get_Role(out pdwRole: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_state</summary>
    function get_State(out pdwState: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_help</summary>
    function get_Help(out pszHelp: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_keyboardshortcut</summary>
    function get_KeyboardShortcut(out pszKeyboardShortcut: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-getselection</summary>
    function GetSelection(out pvarSelectedChildren: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_defaultaction</summary>
    function get_DefaultAction(out pszDefaultAction: PChar): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ILegacyIAccessibleProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccidentity</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.0</i></para>
  ///</remarks>
  IAccIdentity = interface(IUnknown)
  ['{7852B78D-1CFD-41C1-A615-9C0C85960B5F}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccidentity-getidentitystring</summary>
    function GetIdentityString(dwIDChild: Cardinal; out ppIDString: Byte; out pdwIDStringLen: Cardinal): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IAccIdentity}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationinvokepattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationInvokePattern = interface(IUnknown)
  ['{FB377FBE-8EA6-46D5-9C73-6499642D3059}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationinvokepattern-invoke</summary>
    function Invoke: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationInvokePattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationgridpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationGridPattern = interface(IUnknown)
  ['{414C3CDC-856B-4F5B-8538-3131C6302550}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-getitem</summary>
    function GetItem(row: Integer; column: Integer; out element: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-get_currentrowcount</summary>
    function get_CurrentRowCount(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-get_currentcolumncount</summary>
    function get_CurrentColumnCount(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-get_cachedrowcount</summary>
    function get_CachedRowCount(out retVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-get_cachedcolumncount</summary>
    function get_CachedColumnCount(out retVal: Integer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationGridPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iscrollprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IScrollProvider = interface(IUnknown)
  ['{B38B8077-1FC3-42A5-8CAE-D40C2215055A}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-scroll</summary>
    function Scroll(horizontalAmount: ScrollAmount; verticalAmount: ScrollAmount): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-setscrollpercent</summary>
    function SetScrollPercent(horizontalPercent: Double; verticalPercent: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_horizontalscrollpercent</summary>
    function get_HorizontalScrollPercent(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_verticalscrollpercent</summary>
    function get_VerticalScrollPercent(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_horizontalviewsize</summary>
    function get_HorizontalViewSize(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_verticalviewsize</summary>
    function get_VerticalViewSize(out pRetVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_horizontallyscrollable</summary>
    function get_HorizontallyScrollable(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_verticallyscrollable</summary>
    function get_VerticallyScrollable(out pRetVal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IScrollProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtableitempattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationTableItemPattern = interface(IUnknown)
  ['{0B964EB3-EF2E-4464-9C79-61D61737A27E}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtableitempattern-getcurrentrowheaderitems</summary>
    function GetCurrentRowHeaderItems(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtableitempattern-getcurrentcolumnheaderitems</summary>
    function GetCurrentColumnHeaderItems(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtableitempattern-getcachedrowheaderitems</summary>
    function GetCachedRowHeaderItems(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtableitempattern-getcachedcolumnheaderitems</summary>
    function GetCachedColumnHeaderItems(out retVal: IUIAutomationElementArray): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTableItemPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationwindowpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationWindowPattern = interface(IUnknown)
  ['{0FAEF453-9208-43EF-BBB2-3B485177864F}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-close</summary>
    function Close: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-waitforinputidle</summary>
    function WaitForInputIdle(milliseconds: Integer; out success: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-setwindowvisualstate</summary>
    function SetWindowVisualState(state: WindowVisualState): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentcanmaximize</summary>
    function get_CurrentCanMaximize(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentcanminimize</summary>
    function get_CurrentCanMinimize(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentismodal</summary>
    function get_CurrentIsModal(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentistopmost</summary>
    function get_CurrentIsTopmost(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentwindowvisualstate</summary>
    function get_CurrentWindowVisualState(out retVal: WindowVisualState): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentwindowinteractionstate</summary>
    function get_CurrentWindowInteractionState(out retVal: WindowInteractionState): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedcanmaximize</summary>
    function get_CachedCanMaximize(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedcanminimize</summary>
    function get_CachedCanMinimize(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedismodal</summary>
    function get_CachedIsModal(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedistopmost</summary>
    function get_CachedIsTopmost(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedwindowvisualstate</summary>
    function get_CachedWindowVisualState(out retVal: WindowVisualState): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedwindowinteractionstate</summary>
    function get_CachedWindowInteractionState(out retVal: WindowInteractionState): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationWindowPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-idragprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IDragProvider = interface(IUnknown)
  ['{6AA7BBBB-7FF9-497D-904F-D20B897929D8}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idragprovider-get_isgrabbed</summary>
    function get_IsGrabbed(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idragprovider-get_dropeffect</summary>
    function get_DropEffect(out pRetVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idragprovider-get_dropeffects</summary>
    function get_DropEffects(out pRetVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idragprovider-getgrabbeditems</summary>
    function GetGrabbedItems(out pRetVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDragProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationpropertycondition</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationPropertyCondition = interface(IUIAutomationCondition)
  ['{99EBF2CB-5578-4267-9AD4-AFD6EA77E94B}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationpropertycondition-get_propertyid</summary>
    function get_PropertyId(out propertyId: UIA_PROPERTY_ID): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationpropertycondition-get_propertyvalue</summary>
    function get_PropertyValue(out propertyValue: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationpropertycondition-get_propertyconditionflags</summary>
    function get_PropertyConditionFlags(out flags: PropertyConditionFlags): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationPropertyCondition}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtogglepattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationTogglePattern = interface(IUnknown)
  ['{94CF8058-9B8D-4AB9-8BFD-4CD0A33C8C70}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtogglepattern-toggle</summary>
    function Toggle: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtogglepattern-get_currenttogglestate</summary>
    function get_CurrentToggleState(out retVal: ToggleState): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtogglepattern-get_cachedtogglestate</summary>
    function get_CachedToggleState(out retVal: ToggleState): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTogglePattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccpropservices</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IAccPropServices = interface(IUnknown)
  ['{6E26E776-04F0-495D-80E4-3330352E3169}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-setpropvalue</summary>
    function SetPropValue(pIDString: PByte; dwIDStringLen: Cardinal; idProp: TGuid; &var: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-setpropserver</summary>
    function SetPropServer(pIDString: PByte; dwIDStringLen: Cardinal; paProps: PGuid; cProps: Integer; pServer: IAccPropServer; annoScope: AnnoScope): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-clearprops</summary>
    function ClearProps(pIDString: PByte; dwIDStringLen: Cardinal; paProps: PGuid; cProps: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethwndprop</summary>
    function SetHwndProp(hwnd: HWND; idObject: Cardinal; idChild: Cardinal; idProp: TGuid; &var: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethwndpropstr</summary>
    function SetHwndPropStr(hwnd: HWND; idObject: Cardinal; idChild: Cardinal; idProp: TGuid; str: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethwndpropserver</summary>
    function SetHwndPropServer(hwnd: HWND; idObject: Cardinal; idChild: Cardinal; paProps: PGuid; cProps: Integer; pServer: IAccPropServer; annoScope: AnnoScope): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-clearhwndprops</summary>
    function ClearHwndProps(hwnd: HWND; idObject: Cardinal; idChild: Cardinal; paProps: PGuid; cProps: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-composehwndidentitystring</summary>
    function ComposeHwndIdentityString(hwnd: HWND; idObject: Cardinal; idChild: Cardinal; out ppIDString: Byte; out pdwIDStringLen: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-decomposehwndidentitystring</summary>
    function DecomposeHwndIdentityString(pIDString: PByte; dwIDStringLen: Cardinal; out phwnd: HWND; out pidObject: Cardinal; out pidChild: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethmenuprop</summary>
    function SetHmenuProp(hmenu: HMENU; idChild: Cardinal; idProp: TGuid; &var: OleVariant): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethmenupropstr</summary>
    function SetHmenuPropStr(hmenu: HMENU; idChild: Cardinal; idProp: TGuid; str: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethmenupropserver</summary>
    function SetHmenuPropServer(hmenu: HMENU; idChild: Cardinal; paProps: PGuid; cProps: Integer; pServer: IAccPropServer; annoScope: AnnoScope): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-clearhmenuprops</summary>
    function ClearHmenuProps(hmenu: HMENU; idChild: Cardinal; paProps: PGuid; cProps: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-composehmenuidentitystring</summary>
    function ComposeHmenuIdentityString(hmenu: HMENU; idChild: Cardinal; out ppIDString: Byte; out pdwIDStringLen: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-decomposehmenuidentitystring</summary>
    function DecomposeHmenuIdentityString(pIDString: PByte; dwIDStringLen: Cardinal; out phmenu: HMENU; out pidChild: Cardinal): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IAccPropServices}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-idroptargetprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IDropTargetProvider = interface(IUnknown)
  ['{BAE82BFD-358A-481C-85A0-D8B4D90A5D61}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idroptargetprovider-get_droptargeteffect</summary>
    function get_DropTargetEffect(out pRetVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idroptargetprovider-get_droptargeteffects</summary>
    function get_DropTargetEffects(out pRetVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDropTargetProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationdroptargetpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationDropTargetPattern = interface(IUnknown)
  ['{69A095F7-EEE4-430E-A46B-FB73B1AE39A5}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdroptargetpattern-get_currentdroptargeteffect</summary>
    function get_CurrentDropTargetEffect(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdroptargetpattern-get_cacheddroptargeteffect</summary>
    function get_CachedDropTargetEffect(out retVal: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdroptargetpattern-get_currentdroptargeteffects</summary>
    function get_CurrentDropTargetEffects(out retVal: SAFEARRAY): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdroptargetpattern-get_cacheddroptargeteffects</summary>
    function get_CachedDropTargetEffects(out retVal: SAFEARRAY): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationDropTargetPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itexteditprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.1</i></para>
  ///</remarks>
  ITextEditProvider = interface(ITextProvider)
  ['{EA3605B4-3A05-400E-B5F9-4E91B40F6176}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itexteditprovider-getactivecomposition</summary>
    function GetActiveComposition(out pRetVal: ITextRangeProvider): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itexteditprovider-getconversiontarget</summary>
    function GetConversionTarget(out pRetVal: ITextRangeProvider): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITextEditProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iselectionitemprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  ISelectionItemProvider = interface(IUnknown)
  ['{2ACAD808-B2D4-452D-A407-91FF1AD167B2}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionitemprovider-select</summary>
    function Select: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionitemprovider-addtoselection</summary>
    function AddToSelection: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionitemprovider-removefromselection</summary>
    function RemoveFromSelection: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionitemprovider-get_isselected</summary>
    function get_IsSelected(out pRetVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionitemprovider-get_selectioncontainer</summary>
    function get_SelectionContainer(out pRetVal: IRawElementProviderSimple): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISelectionItemProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itextchildprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  ITextChildProvider = interface(IUnknown)
  ['{4C2DE2B9-C88F-4F88-A111-F1D336B7D1A9}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextchildprovider-get_textcontainer</summary>
    function get_TextContainer(out pRetVal: IRawElementProviderSimple): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextchildprovider-get_textrange</summary>
    function get_TextRange(out pRetVal: ITextRangeProvider): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITextChildProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationdockpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationDockPattern = interface(IUnknown)
  ['{FDE5EF97-1464-48F6-90BF-43D0948E86EC}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdockpattern-setdockposition</summary>
    function SetDockPosition(dockPos: DockPosition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdockpattern-get_currentdockposition</summary>
    function get_CurrentDockPosition(out retVal: DockPosition): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdockpattern-get_cacheddockposition</summary>
    function get_CachedDockPosition(out retVal: DockPosition): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationDockPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationobjectmodelpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationObjectModelPattern = interface(IUnknown)
  ['{71C284B3-C14D-4D14-981E-19751B0D756D}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationobjectmodelpattern-getunderlyingobjectmodel</summary>
    function GetUnderlyingObjectModel(out retVal: IUnknown): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationObjectModelPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iuiautomationpatternhandler</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationPatternHandler = interface(IUnknown)
  ['{D97022F3-A947-465E-8B2A-AC4315FA54E8}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationpatternhandler-createclientwrapper</summary>
    function CreateClientWrapper(pPatternInstance: IUIAutomationPatternInstance; out pClientWrapper: IUnknown): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationpatternhandler-dispatch</summary>
    function Dispatch(pTarget: IUnknown; index: Cardinal; pParams: PUIAutomationParameter; cParams: Cardinal): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationPatternHandler}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iuiautomationregistrar</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationRegistrar = interface(IUnknown)
  ['{8609C4EC-4A1A-4D88-A357-5A66E060E1CF}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationregistrar-registerproperty</summary>
    function RegisterProperty(&property: PUIAutomationPropertyInfo; out propertyId: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationregistrar-registerevent</summary>
    function RegisterEvent(event: PUIAutomationEventInfo; out eventId: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationregistrar-registerpattern</summary>
    function RegisterPattern(pattern: PUIAutomationPatternInfo; out pPatternId: Integer; out pPatternAvailablePropertyId: Integer; propertyIdCount: Cardinal; out pPropertyIds: Integer; eventIdCount: Cardinal; out pEventIds: Integer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationRegistrar}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtransformpattern2</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationTransformPattern2 = interface(IUIAutomationTransformPattern)
  ['{6D74D017-6ECB-4381-B38B-3C17A48FF1C2}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-zoom</summary>
    function Zoom(zoomValue: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-zoombyunit</summary>
    function ZoomByUnit(zoomUnit: ZoomUnit): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentcanzoom</summary>
    function get_CurrentCanZoom(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_cachedcanzoom</summary>
    function get_CachedCanZoom(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentzoomlevel</summary>
    function get_CurrentZoomLevel(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_cachedzoomlevel</summary>
    function get_CachedZoomLevel(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentzoomminimum</summary>
    function get_CurrentZoomMinimum(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_cachedzoomminimum</summary>
    function get_CachedZoomMinimum(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentzoommaximum</summary>
    function get_CurrentZoomMaximum(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_cachedzoommaximum</summary>
    function get_CachedZoomMaximum(out retVal: Double): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTransformPattern2}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationlegacyiaccessiblepattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationLegacyIAccessiblePattern = interface(IUnknown)
  ['{828055AD-355B-4435-86D5-3B51C14A9B1B}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-select</summary>
    function Select(flagsSelect: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-dodefaultaction</summary>
    function DoDefaultAction: HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-setvalue</summary>
    function SetValue(szValue: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentchildid</summary>
    function get_CurrentChildId(out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentname</summary>
    function get_CurrentName(out pszName: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentvalue</summary>
    function get_CurrentValue(out pszValue: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentdescription</summary>
    function get_CurrentDescription(out pszDescription: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentrole</summary>
    function get_CurrentRole(out pdwRole: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentstate</summary>
    function get_CurrentState(out pdwState: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currenthelp</summary>
    function get_CurrentHelp(out pszHelp: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentkeyboardshortcut</summary>
    function get_CurrentKeyboardShortcut(out pszKeyboardShortcut: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-getcurrentselection</summary>
    function GetCurrentSelection(out pvarSelectedChildren: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentdefaultaction</summary>
    function get_CurrentDefaultAction(out pszDefaultAction: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedchildid</summary>
    function get_CachedChildId(out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedname</summary>
    function get_CachedName(out pszName: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedvalue</summary>
    function get_CachedValue(out pszValue: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cacheddescription</summary>
    function get_CachedDescription(out pszDescription: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedrole</summary>
    function get_CachedRole(out pdwRole: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedstate</summary>
    function get_CachedState(out pdwState: Cardinal): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedhelp</summary>
    function get_CachedHelp(out pszHelp: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedkeyboardshortcut</summary>
    function get_CachedKeyboardShortcut(out pszKeyboardShortcut: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-getcachedselection</summary>
    function GetCachedSelection(out pvarSelectedChildren: IUIAutomationElementArray): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cacheddefaultaction</summary>
    function get_CachedDefaultAction(out pszDefaultAction: PChar): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-getiaccessible</summary>
    function GetIAccessible(out ppAccessible: IAccessible): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationLegacyIAccessiblePattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationnotcondition</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationNotCondition = interface(IUIAutomationCondition)
  ['{F528B657-847B-498C-8896-D52B565407A1}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationnotcondition-getchild</summary>
    function GetChild(out condition: IUIAutomationCondition): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationNotCondition}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationvirtualizeditempattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationVirtualizedItemPattern = interface(IUnknown)
  ['{6BA3D7A6-04CF-4F11-8793-A8D1CDE9969F}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvirtualizeditempattern-realize</summary>
    function Realize: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationVirtualizedItemPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-igriditemprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows5.1.2600</i></para>
  ///</remarks>
  IGridItemProvider = interface(IUnknown)
  ['{D02541F1-FB81-4D64-AE32-F520F8A6DBD1}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igriditemprovider-get_row</summary>
    function get_Row(out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igriditemprovider-get_column</summary>
    function get_Column(out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igriditemprovider-get_rowspan</summary>
    function get_RowSpan(out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igriditemprovider-get_columnspan</summary>
    function get_ColumnSpan(out pRetVal: Integer): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igriditemprovider-get_containinggrid</summary>
    function get_ContainingGrid(out pRetVal: IRawElementProviderSimple): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IGridItemProvider}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationspreadsheetpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationSpreadsheetPattern = interface(IUnknown)
  ['{7517A7C8-FAAE-4DE9-9F08-29B91E8595C1}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetpattern-getitembyname</summary>
    function GetItemByName(name: PChar; out element: IUIAutomationElement): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationSpreadsheetPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationrangevaluepattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows6.1</i></para>
  ///</remarks>
  IUIAutomationRangeValuePattern = interface(IUnknown)
  ['{59213F4F-7346-49E5-B120-80555987A148}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-setvalue</summary>
    function SetValue(val: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentvalue</summary>
    function get_CurrentValue(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentisreadonly</summary>
    function get_CurrentIsReadOnly(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentmaximum</summary>
    function get_CurrentMaximum(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentminimum</summary>
    function get_CurrentMinimum(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentlargechange</summary>
    function get_CurrentLargeChange(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentsmallchange</summary>
    function get_CurrentSmallChange(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedvalue</summary>
    function get_CachedValue(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedisreadonly</summary>
    function get_CachedIsReadOnly(out retVal: BOOL): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedmaximum</summary>
    function get_CachedMaximum(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedminimum</summary>
    function get_CachedMinimum(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedlargechange</summary>
    function get_CachedLargeChange(out retVal: Double): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedsmallchange</summary>
    function get_CachedSmallChange(out retVal: Double): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationRangeValuePattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextchildpattern</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  IUIAutomationTextChildPattern = interface(IUnknown)
  ['{6552B038-AE05-40C8-ABFD-AA08352AAB86}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextchildpattern-get_textcontainer</summary>
    function get_TextContainer(out container: IUIAutomationElement): HRESULT; stdcall;
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextchildpattern-get_textrange</summary>
    function get_TextRange(out range: IUIAutomationTextRange): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IUIAutomationTextChildPattern}

  ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-ispreadsheetprovider</summary>
  ///<remarks>
  ///<para>Supported since: <i>windows8.0</i></para>
  ///</remarks>
  ISpreadsheetProvider = interface(IUnknown)
  ['{6F6B5D35-5525-4F80-B758-85473832FFC7}']
    ///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ispreadsheetprovider-getitembyname</summary>
    function GetItemByName(name: PChar; out pRetVal: IRawElementProviderSimple): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISpreadsheetProvider}

const

  // Windows  UI Automation API constants

  LIBID_Accessibility: TGuid = '{1EA4DBF0-3C3B-11CF-810C-00AA00389B71}';
  {$EXTERNALSYM LIBID_Accessibility}
  CLSID_AccPropServices: TGuid = '{B5F8350B-0548-48B1-A6EE-88BD00B4A5E7}';
  {$EXTERNALSYM CLSID_AccPropServices}
  IIS_IsOleaccProxy: TGuid = '{902697FA-80E4-4560-802A-A13F22A64709}';
  {$EXTERNALSYM IIS_IsOleaccProxy}
  IIS_ControlAccessible: TGuid = '{38C682A6-9731-43F2-9FAE-E901E641B101}';
  {$EXTERNALSYM IIS_ControlAccessible}
  ANRUS_PRIORITY_AUDIO_DYNAMIC_DUCK = $10 {16};
  {$EXTERNALSYM ANRUS_PRIORITY_AUDIO_DYNAMIC_DUCK}
  MSAA_MENU_SIG = $AA0DF00D {-1441927155};
  {$EXTERNALSYM MSAA_MENU_SIG}
  PROPID_ACC_NAME: TGuid = '{608D3DF8-8128-4AA7-A428-F55E49267291}';
  {$EXTERNALSYM PROPID_ACC_NAME}
  PROPID_ACC_VALUE: TGuid = '{123FE443-211A-4615-9527-C45A7E93717A}';
  {$EXTERNALSYM PROPID_ACC_VALUE}
  PROPID_ACC_DESCRIPTION: TGuid = '{4D48DFE4-BD3F-491F-A648-492D6F20C588}';
  {$EXTERNALSYM PROPID_ACC_DESCRIPTION}
  PROPID_ACC_ROLE: TGuid = '{CB905FF2-7BD1-4C05-B3C8-E6C241364D70}';
  {$EXTERNALSYM PROPID_ACC_ROLE}
  PROPID_ACC_STATE: TGuid = '{A8D4D5B0-0A21-42D0-A5C0-514E984F457B}';
  {$EXTERNALSYM PROPID_ACC_STATE}
  PROPID_ACC_HELP: TGuid = '{C831E11F-44DB-4A99-9768-CB8F978B7231}';
  {$EXTERNALSYM PROPID_ACC_HELP}
  PROPID_ACC_KEYBOARDSHORTCUT: TGuid = '{7D9BCEEE-7D1E-4979-9382-5180F4172C34}';
  {$EXTERNALSYM PROPID_ACC_KEYBOARDSHORTCUT}
  PROPID_ACC_DEFAULTACTION: TGuid = '{180C072B-C27F-43C7-9922-F63562A4632B}';
  {$EXTERNALSYM PROPID_ACC_DEFAULTACTION}
  PROPID_ACC_HELPTOPIC: TGuid = '{787D1379-8EDE-440B-8AEC-11F7BF9030B3}';
  {$EXTERNALSYM PROPID_ACC_HELPTOPIC}
  PROPID_ACC_FOCUS: TGuid = '{6EB335DF-1C29-4127-B12C-DEE9FD157F2B}';
  {$EXTERNALSYM PROPID_ACC_FOCUS}
  PROPID_ACC_SELECTION: TGuid = '{B99D073C-D731-405B-9061-D95E8F842984}';
  {$EXTERNALSYM PROPID_ACC_SELECTION}
  PROPID_ACC_PARENT: TGuid = '{474C22B6-FFC2-467A-B1B5-E958B4657330}';
  {$EXTERNALSYM PROPID_ACC_PARENT}
  PROPID_ACC_NAV_UP: TGuid = '{016E1A2B-1A4E-4767-8612-3386F66935EC}';
  {$EXTERNALSYM PROPID_ACC_NAV_UP}
  PROPID_ACC_NAV_DOWN: TGuid = '{031670ED-3CDF-48D2-9613-138F2DD8A668}';
  {$EXTERNALSYM PROPID_ACC_NAV_DOWN}
  PROPID_ACC_NAV_LEFT: TGuid = '{228086CB-82F1-4A39-8705-DCDC0FFF92F5}';
  {$EXTERNALSYM PROPID_ACC_NAV_LEFT}
  PROPID_ACC_NAV_RIGHT: TGuid = '{CD211D9F-E1CB-4FE5-A77C-920B884D095B}';
  {$EXTERNALSYM PROPID_ACC_NAV_RIGHT}
  PROPID_ACC_NAV_PREV: TGuid = '{776D3891-C73B-4480-B3F6-076A16A15AF6}';
  {$EXTERNALSYM PROPID_ACC_NAV_PREV}
  PROPID_ACC_NAV_NEXT: TGuid = '{1CDC5455-8CD9-4C92-A371-3939A2FE3EEE}';
  {$EXTERNALSYM PROPID_ACC_NAV_NEXT}
  PROPID_ACC_NAV_FIRSTCHILD: TGuid = '{CFD02558-557B-4C67-84F9-2A09FCE40749}';
  {$EXTERNALSYM PROPID_ACC_NAV_FIRSTCHILD}
  PROPID_ACC_NAV_LASTCHILD: TGuid = '{302ECAA5-48D5-4F8D-B671-1A8D20A77832}';
  {$EXTERNALSYM PROPID_ACC_NAV_LASTCHILD}
  PROPID_ACC_ROLEMAP: TGuid = '{F79ACDA2-140D-4FE6-8914-208476328269}';
  {$EXTERNALSYM PROPID_ACC_ROLEMAP}
  PROPID_ACC_VALUEMAP: TGuid = '{DA1C3D79-FC5C-420E-B399-9D1533549E75}';
  {$EXTERNALSYM PROPID_ACC_VALUEMAP}
  PROPID_ACC_STATEMAP: TGuid = '{43946C5E-0AC0-4042-B525-07BBDBE17FA7}';
  {$EXTERNALSYM PROPID_ACC_STATEMAP}
  PROPID_ACC_DESCRIPTIONMAP: TGuid = '{1FF1435F-8A14-477B-B226-A0ABE279975D}';
  {$EXTERNALSYM PROPID_ACC_DESCRIPTIONMAP}
  PROPID_ACC_DODEFAULTACTION: TGuid = '{1BA09523-2E3B-49A6-A059-59682A3C48FD}';
  {$EXTERNALSYM PROPID_ACC_DODEFAULTACTION}
  DISPID_ACC_PARENT = $FFFFEC78 {-5000};
  {$EXTERNALSYM DISPID_ACC_PARENT}
  DISPID_ACC_CHILDCOUNT = $FFFFEC77 {-5001};
  {$EXTERNALSYM DISPID_ACC_CHILDCOUNT}
  DISPID_ACC_CHILD = $FFFFEC76 {-5002};
  {$EXTERNALSYM DISPID_ACC_CHILD}
  DISPID_ACC_NAME = $FFFFEC75 {-5003};
  {$EXTERNALSYM DISPID_ACC_NAME}
  DISPID_ACC_VALUE = $FFFFEC74 {-5004};
  {$EXTERNALSYM DISPID_ACC_VALUE}
  DISPID_ACC_DESCRIPTION = $FFFFEC73 {-5005};
  {$EXTERNALSYM DISPID_ACC_DESCRIPTION}
  DISPID_ACC_ROLE = $FFFFEC72 {-5006};
  {$EXTERNALSYM DISPID_ACC_ROLE}
  DISPID_ACC_STATE = $FFFFEC71 {-5007};
  {$EXTERNALSYM DISPID_ACC_STATE}
  DISPID_ACC_HELP = $FFFFEC70 {-5008};
  {$EXTERNALSYM DISPID_ACC_HELP}
  DISPID_ACC_HELPTOPIC = $FFFFEC6F {-5009};
  {$EXTERNALSYM DISPID_ACC_HELPTOPIC}
  DISPID_ACC_KEYBOARDSHORTCUT = $FFFFEC6E {-5010};
  {$EXTERNALSYM DISPID_ACC_KEYBOARDSHORTCUT}
  DISPID_ACC_FOCUS = $FFFFEC6D {-5011};
  {$EXTERNALSYM DISPID_ACC_FOCUS}
  DISPID_ACC_SELECTION = $FFFFEC6C {-5012};
  {$EXTERNALSYM DISPID_ACC_SELECTION}
  DISPID_ACC_DEFAULTACTION = $FFFFEC6B {-5013};
  {$EXTERNALSYM DISPID_ACC_DEFAULTACTION}
  DISPID_ACC_SELECT = $FFFFEC6A {-5014};
  {$EXTERNALSYM DISPID_ACC_SELECT}
  DISPID_ACC_LOCATION = $FFFFEC69 {-5015};
  {$EXTERNALSYM DISPID_ACC_LOCATION}
  DISPID_ACC_NAVIGATE = $FFFFEC68 {-5016};
  {$EXTERNALSYM DISPID_ACC_NAVIGATE}
  DISPID_ACC_HITTEST = $FFFFEC67 {-5017};
  {$EXTERNALSYM DISPID_ACC_HITTEST}
  DISPID_ACC_DODEFAULTACTION = $FFFFEC66 {-5018};
  {$EXTERNALSYM DISPID_ACC_DODEFAULTACTION}
  NAVDIR_MIN = $0 {0};
  {$EXTERNALSYM NAVDIR_MIN}
  NAVDIR_UP = $1 {1};
  {$EXTERNALSYM NAVDIR_UP}
  NAVDIR_DOWN = $2 {2};
  {$EXTERNALSYM NAVDIR_DOWN}
  NAVDIR_LEFT = $3 {3};
  {$EXTERNALSYM NAVDIR_LEFT}
  NAVDIR_RIGHT = $4 {4};
  {$EXTERNALSYM NAVDIR_RIGHT}
  NAVDIR_NEXT = $5 {5};
  {$EXTERNALSYM NAVDIR_NEXT}
  NAVDIR_PREVIOUS = $6 {6};
  {$EXTERNALSYM NAVDIR_PREVIOUS}
  NAVDIR_FIRSTCHILD = $7 {7};
  {$EXTERNALSYM NAVDIR_FIRSTCHILD}
  NAVDIR_LASTCHILD = $8 {8};
  {$EXTERNALSYM NAVDIR_LASTCHILD}
  NAVDIR_MAX = $9 {9};
  {$EXTERNALSYM NAVDIR_MAX}
  SELFLAG_NONE = $0 {0};
  {$EXTERNALSYM SELFLAG_NONE}
  SELFLAG_TAKEFOCUS = $1 {1};
  {$EXTERNALSYM SELFLAG_TAKEFOCUS}
  SELFLAG_TAKESELECTION = $2 {2};
  {$EXTERNALSYM SELFLAG_TAKESELECTION}
  SELFLAG_EXTENDSELECTION = $4 {4};
  {$EXTERNALSYM SELFLAG_EXTENDSELECTION}
  SELFLAG_ADDSELECTION = $8 {8};
  {$EXTERNALSYM SELFLAG_ADDSELECTION}
  SELFLAG_REMOVESELECTION = $10 {16};
  {$EXTERNALSYM SELFLAG_REMOVESELECTION}
  SELFLAG_VALID = $1F {31};
  {$EXTERNALSYM SELFLAG_VALID}
  STATE_SYSTEM_NORMAL = $0 {0};
  {$EXTERNALSYM STATE_SYSTEM_NORMAL}
  STATE_SYSTEM_HASPOPUP = $40000000 {1073741824};
  {$EXTERNALSYM STATE_SYSTEM_HASPOPUP}
  ROLE_SYSTEM_TITLEBAR = $1 {1};
  {$EXTERNALSYM ROLE_SYSTEM_TITLEBAR}
  ROLE_SYSTEM_MENUBAR = $2 {2};
  {$EXTERNALSYM ROLE_SYSTEM_MENUBAR}
  ROLE_SYSTEM_SCROLLBAR = $3 {3};
  {$EXTERNALSYM ROLE_SYSTEM_SCROLLBAR}
  ROLE_SYSTEM_GRIP = $4 {4};
  {$EXTERNALSYM ROLE_SYSTEM_GRIP}
  ROLE_SYSTEM_SOUND = $5 {5};
  {$EXTERNALSYM ROLE_SYSTEM_SOUND}
  ROLE_SYSTEM_CURSOR = $6 {6};
  {$EXTERNALSYM ROLE_SYSTEM_CURSOR}
  ROLE_SYSTEM_CARET = $7 {7};
  {$EXTERNALSYM ROLE_SYSTEM_CARET}
  ROLE_SYSTEM_ALERT = $8 {8};
  {$EXTERNALSYM ROLE_SYSTEM_ALERT}
  ROLE_SYSTEM_WINDOW = $9 {9};
  {$EXTERNALSYM ROLE_SYSTEM_WINDOW}
  ROLE_SYSTEM_CLIENT = $A {10};
  {$EXTERNALSYM ROLE_SYSTEM_CLIENT}
  ROLE_SYSTEM_MENUPOPUP = $B {11};
  {$EXTERNALSYM ROLE_SYSTEM_MENUPOPUP}
  ROLE_SYSTEM_MENUITEM = $C {12};
  {$EXTERNALSYM ROLE_SYSTEM_MENUITEM}
  ROLE_SYSTEM_TOOLTIP = $D {13};
  {$EXTERNALSYM ROLE_SYSTEM_TOOLTIP}
  ROLE_SYSTEM_APPLICATION = $E {14};
  {$EXTERNALSYM ROLE_SYSTEM_APPLICATION}
  ROLE_SYSTEM_DOCUMENT = $F {15};
  {$EXTERNALSYM ROLE_SYSTEM_DOCUMENT}
  ROLE_SYSTEM_PANE = $10 {16};
  {$EXTERNALSYM ROLE_SYSTEM_PANE}
  ROLE_SYSTEM_CHART = $11 {17};
  {$EXTERNALSYM ROLE_SYSTEM_CHART}
  ROLE_SYSTEM_DIALOG = $12 {18};
  {$EXTERNALSYM ROLE_SYSTEM_DIALOG}
  ROLE_SYSTEM_BORDER = $13 {19};
  {$EXTERNALSYM ROLE_SYSTEM_BORDER}
  ROLE_SYSTEM_GROUPING = $14 {20};
  {$EXTERNALSYM ROLE_SYSTEM_GROUPING}
  ROLE_SYSTEM_SEPARATOR = $15 {21};
  {$EXTERNALSYM ROLE_SYSTEM_SEPARATOR}
  ROLE_SYSTEM_TOOLBAR = $16 {22};
  {$EXTERNALSYM ROLE_SYSTEM_TOOLBAR}
  ROLE_SYSTEM_STATUSBAR = $17 {23};
  {$EXTERNALSYM ROLE_SYSTEM_STATUSBAR}
  ROLE_SYSTEM_TABLE = $18 {24};
  {$EXTERNALSYM ROLE_SYSTEM_TABLE}
  ROLE_SYSTEM_COLUMNHEADER = $19 {25};
  {$EXTERNALSYM ROLE_SYSTEM_COLUMNHEADER}
  ROLE_SYSTEM_ROWHEADER = $1A {26};
  {$EXTERNALSYM ROLE_SYSTEM_ROWHEADER}
  ROLE_SYSTEM_COLUMN = $1B {27};
  {$EXTERNALSYM ROLE_SYSTEM_COLUMN}
  ROLE_SYSTEM_ROW = $1C {28};
  {$EXTERNALSYM ROLE_SYSTEM_ROW}
  ROLE_SYSTEM_CELL = $1D {29};
  {$EXTERNALSYM ROLE_SYSTEM_CELL}
  ROLE_SYSTEM_LINK = $1E {30};
  {$EXTERNALSYM ROLE_SYSTEM_LINK}
  ROLE_SYSTEM_HELPBALLOON = $1F {31};
  {$EXTERNALSYM ROLE_SYSTEM_HELPBALLOON}
  ROLE_SYSTEM_CHARACTER = $20 {32};
  {$EXTERNALSYM ROLE_SYSTEM_CHARACTER}
  ROLE_SYSTEM_LIST = $21 {33};
  {$EXTERNALSYM ROLE_SYSTEM_LIST}
  ROLE_SYSTEM_LISTITEM = $22 {34};
  {$EXTERNALSYM ROLE_SYSTEM_LISTITEM}
  ROLE_SYSTEM_OUTLINE = $23 {35};
  {$EXTERNALSYM ROLE_SYSTEM_OUTLINE}
  ROLE_SYSTEM_OUTLINEITEM = $24 {36};
  {$EXTERNALSYM ROLE_SYSTEM_OUTLINEITEM}
  ROLE_SYSTEM_PAGETAB = $25 {37};
  {$EXTERNALSYM ROLE_SYSTEM_PAGETAB}
  ROLE_SYSTEM_PROPERTYPAGE = $26 {38};
  {$EXTERNALSYM ROLE_SYSTEM_PROPERTYPAGE}
  ROLE_SYSTEM_INDICATOR = $27 {39};
  {$EXTERNALSYM ROLE_SYSTEM_INDICATOR}
  ROLE_SYSTEM_GRAPHIC = $28 {40};
  {$EXTERNALSYM ROLE_SYSTEM_GRAPHIC}
  ROLE_SYSTEM_STATICTEXT = $29 {41};
  {$EXTERNALSYM ROLE_SYSTEM_STATICTEXT}
  ROLE_SYSTEM_TEXT = $2A {42};
  {$EXTERNALSYM ROLE_SYSTEM_TEXT}
  ROLE_SYSTEM_PUSHBUTTON = $2B {43};
  {$EXTERNALSYM ROLE_SYSTEM_PUSHBUTTON}
  ROLE_SYSTEM_CHECKBUTTON = $2C {44};
  {$EXTERNALSYM ROLE_SYSTEM_CHECKBUTTON}
  ROLE_SYSTEM_RADIOBUTTON = $2D {45};
  {$EXTERNALSYM ROLE_SYSTEM_RADIOBUTTON}
  ROLE_SYSTEM_COMBOBOX = $2E {46};
  {$EXTERNALSYM ROLE_SYSTEM_COMBOBOX}
  ROLE_SYSTEM_DROPLIST = $2F {47};
  {$EXTERNALSYM ROLE_SYSTEM_DROPLIST}
  ROLE_SYSTEM_PROGRESSBAR = $30 {48};
  {$EXTERNALSYM ROLE_SYSTEM_PROGRESSBAR}
  ROLE_SYSTEM_DIAL = $31 {49};
  {$EXTERNALSYM ROLE_SYSTEM_DIAL}
  ROLE_SYSTEM_HOTKEYFIELD = $32 {50};
  {$EXTERNALSYM ROLE_SYSTEM_HOTKEYFIELD}
  ROLE_SYSTEM_SLIDER = $33 {51};
  {$EXTERNALSYM ROLE_SYSTEM_SLIDER}
  ROLE_SYSTEM_SPINBUTTON = $34 {52};
  {$EXTERNALSYM ROLE_SYSTEM_SPINBUTTON}
  ROLE_SYSTEM_DIAGRAM = $35 {53};
  {$EXTERNALSYM ROLE_SYSTEM_DIAGRAM}
  ROLE_SYSTEM_ANIMATION = $36 {54};
  {$EXTERNALSYM ROLE_SYSTEM_ANIMATION}
  ROLE_SYSTEM_EQUATION = $37 {55};
  {$EXTERNALSYM ROLE_SYSTEM_EQUATION}
  ROLE_SYSTEM_BUTTONDROPDOWN = $38 {56};
  {$EXTERNALSYM ROLE_SYSTEM_BUTTONDROPDOWN}
  ROLE_SYSTEM_BUTTONMENU = $39 {57};
  {$EXTERNALSYM ROLE_SYSTEM_BUTTONMENU}
  ROLE_SYSTEM_BUTTONDROPDOWNGRID = $3A {58};
  {$EXTERNALSYM ROLE_SYSTEM_BUTTONDROPDOWNGRID}
  ROLE_SYSTEM_WHITESPACE = $3B {59};
  {$EXTERNALSYM ROLE_SYSTEM_WHITESPACE}
  ROLE_SYSTEM_PAGETABLIST = $3C {60};
  {$EXTERNALSYM ROLE_SYSTEM_PAGETABLIST}
  ROLE_SYSTEM_CLOCK = $3D {61};
  {$EXTERNALSYM ROLE_SYSTEM_CLOCK}
  ROLE_SYSTEM_SPLITBUTTON = $3E {62};
  {$EXTERNALSYM ROLE_SYSTEM_SPLITBUTTON}
  ROLE_SYSTEM_IPADDRESS = $3F {63};
  {$EXTERNALSYM ROLE_SYSTEM_IPADDRESS}
  ROLE_SYSTEM_OUTLINEBUTTON = $40 {64};
  {$EXTERNALSYM ROLE_SYSTEM_OUTLINEBUTTON}
  UIA_E_ELEMENTNOTENABLED = $80040200 {-2147220992};
  {$EXTERNALSYM UIA_E_ELEMENTNOTENABLED}
  UIA_E_ELEMENTNOTAVAILABLE = $80040201 {-2147220991};
  {$EXTERNALSYM UIA_E_ELEMENTNOTAVAILABLE}
  UIA_E_NOCLICKABLEPOINT = $80040202 {-2147220990};
  {$EXTERNALSYM UIA_E_NOCLICKABLEPOINT}
  UIA_E_PROXYASSEMBLYNOTLOADED = $80040203 {-2147220989};
  {$EXTERNALSYM UIA_E_PROXYASSEMBLYNOTLOADED}
  UIA_E_NOTSUPPORTED = $80040204 {-2147220988};
  {$EXTERNALSYM UIA_E_NOTSUPPORTED}
  UIA_E_INVALIDOPERATION = $80131509 {-2146233079};
  {$EXTERNALSYM UIA_E_INVALIDOPERATION}
  UIA_E_TIMEOUT = $80131505 {-2146233083};
  {$EXTERNALSYM UIA_E_TIMEOUT}
  UiaAppendRuntimeId = $3 {3};
  {$EXTERNALSYM UiaAppendRuntimeId}
  UiaRootObjectId = $FFFFFFE7 {-25};
  {$EXTERNALSYM UiaRootObjectId}
  RuntimeId_Property_GUID: TGuid = '{A39EEBFA-7FBA-4C89-B4D4-B99E2DE7D160}';
  {$EXTERNALSYM RuntimeId_Property_GUID}
  BoundingRectangle_Property_GUID: TGuid = '{7BBFE8B2-3BFC-48DD-B729-C794B846E9A1}';
  {$EXTERNALSYM BoundingRectangle_Property_GUID}
  ProcessId_Property_GUID: TGuid = '{40499998-9C31-4245-A403-87320E59EAF6}';
  {$EXTERNALSYM ProcessId_Property_GUID}
  ControlType_Property_GUID: TGuid = '{CA774FEA-28AC-4BC2-94CA-ACEC6D6C10A3}';
  {$EXTERNALSYM ControlType_Property_GUID}
  LocalizedControlType_Property_GUID: TGuid = '{8763404F-A1BD-452A-89C4-3F01D3833806}';
  {$EXTERNALSYM LocalizedControlType_Property_GUID}
  Name_Property_GUID: TGuid = '{C3A6921B-4A99-44F1-BCA6-61187052C431}';
  {$EXTERNALSYM Name_Property_GUID}
  AcceleratorKey_Property_GUID: TGuid = '{514865DF-2557-4CB9-AEED-6CED084CE52C}';
  {$EXTERNALSYM AcceleratorKey_Property_GUID}
  AccessKey_Property_GUID: TGuid = '{06827B12-A7F9-4A15-917C-FFA5AD3EB0A7}';
  {$EXTERNALSYM AccessKey_Property_GUID}
  HasKeyboardFocus_Property_GUID: TGuid = '{CF8AFD39-3F46-4800-9656-B2BF12529905}';
  {$EXTERNALSYM HasKeyboardFocus_Property_GUID}
  IsKeyboardFocusable_Property_GUID: TGuid = '{F7B8552A-0859-4B37-B9CB-51E72092F29F}';
  {$EXTERNALSYM IsKeyboardFocusable_Property_GUID}
  IsEnabled_Property_GUID: TGuid = '{2109427F-DA60-4FED-BF1B-264BDCE6EB3A}';
  {$EXTERNALSYM IsEnabled_Property_GUID}
  AutomationId_Property_GUID: TGuid = '{C82C0500-B60E-4310-A267-303C531F8EE5}';
  {$EXTERNALSYM AutomationId_Property_GUID}
  ClassName_Property_GUID: TGuid = '{157B7215-894F-4B65-84E2-AAC0DA08B16B}';
  {$EXTERNALSYM ClassName_Property_GUID}
  HelpText_Property_GUID: TGuid = '{08555685-0977-45C7-A7A6-ABAF5684121A}';
  {$EXTERNALSYM HelpText_Property_GUID}
  ClickablePoint_Property_GUID: TGuid = '{0196903B-B203-4818-A9F3-F08E675F2341}';
  {$EXTERNALSYM ClickablePoint_Property_GUID}
  Culture_Property_GUID: TGuid = '{E2D74F27-3D79-4DC2-B88B-3044963A8AFB}';
  {$EXTERNALSYM Culture_Property_GUID}
  IsControlElement_Property_GUID: TGuid = '{95F35085-ABCC-4AFD-A5F4-DBB46C230FDB}';
  {$EXTERNALSYM IsControlElement_Property_GUID}
  IsContentElement_Property_GUID: TGuid = '{4BDA64A8-F5D8-480B-8155-EF2E89ADB672}';
  {$EXTERNALSYM IsContentElement_Property_GUID}
  LabeledBy_Property_GUID: TGuid = '{E5B8924B-FC8A-4A35-8031-CF78AC43E55E}';
  {$EXTERNALSYM LabeledBy_Property_GUID}
  IsPassword_Property_GUID: TGuid = '{E8482EB1-687C-497B-BEBC-03BE53EC1454}';
  {$EXTERNALSYM IsPassword_Property_GUID}
  NewNativeWindowHandle_Property_GUID: TGuid = '{5196B33B-380A-4982-95E1-91F3EF60E024}';
  {$EXTERNALSYM NewNativeWindowHandle_Property_GUID}
  ItemType_Property_GUID: TGuid = '{CDDA434D-6222-413B-A68A-325DD1D40F39}';
  {$EXTERNALSYM ItemType_Property_GUID}
  IsOffscreen_Property_GUID: TGuid = '{03C3D160-DB79-42DB-A2EF-1C231EEDE507}';
  {$EXTERNALSYM IsOffscreen_Property_GUID}
  Orientation_Property_GUID: TGuid = '{A01EEE62-3884-4415-887E-678EC21E39BA}';
  {$EXTERNALSYM Orientation_Property_GUID}
  FrameworkId_Property_GUID: TGuid = '{DBFD9900-7E1A-4F58-B61B-7063120F773B}';
  {$EXTERNALSYM FrameworkId_Property_GUID}
  IsRequiredForForm_Property_GUID: TGuid = '{4F5F43CF-59FB-4BDE-A270-602E5E1141E9}';
  {$EXTERNALSYM IsRequiredForForm_Property_GUID}
  ItemStatus_Property_GUID: TGuid = '{51DE0321-3973-43E7-8913-0B08E813C37F}';
  {$EXTERNALSYM ItemStatus_Property_GUID}
  AriaRole_Property_GUID: TGuid = '{DD207B95-BE4A-4E0D-B727-63ACE94B6916}';
  {$EXTERNALSYM AriaRole_Property_GUID}
  AriaProperties_Property_GUID: TGuid = '{4213678C-E025-4922-BEB5-E43BA08E6221}';
  {$EXTERNALSYM AriaProperties_Property_GUID}
  IsDataValidForForm_Property_GUID: TGuid = '{445AC684-C3FC-4DD9-ACF8-845A579296BA}';
  {$EXTERNALSYM IsDataValidForForm_Property_GUID}
  ControllerFor_Property_GUID: TGuid = '{51124C8A-A5D2-4F13-9BE6-7FA8BA9D3A90}';
  {$EXTERNALSYM ControllerFor_Property_GUID}
  DescribedBy_Property_GUID: TGuid = '{7C5865B8-9992-40FD-8DB0-6BF1D317F998}';
  {$EXTERNALSYM DescribedBy_Property_GUID}
  FlowsTo_Property_GUID: TGuid = '{E4F33D20-559A-47FB-A830-F9CB4FF1A70A}';
  {$EXTERNALSYM FlowsTo_Property_GUID}
  ProviderDescription_Property_GUID: TGuid = '{DCA5708A-C16B-4CD9-B889-BEB16A804904}';
  {$EXTERNALSYM ProviderDescription_Property_GUID}
  OptimizeForVisualContent_Property_GUID: TGuid = '{6A852250-C75A-4E5D-B858-E381B0F78861}';
  {$EXTERNALSYM OptimizeForVisualContent_Property_GUID}
  IsDockPatternAvailable_Property_GUID: TGuid = '{2600A4C4-2FF8-4C96-AE31-8FE619A13C6C}';
  {$EXTERNALSYM IsDockPatternAvailable_Property_GUID}
  IsExpandCollapsePatternAvailable_Property_GUID: TGuid = '{929D3806-5287-4725-AA16-222AFC63D595}';
  {$EXTERNALSYM IsExpandCollapsePatternAvailable_Property_GUID}
  IsGridItemPatternAvailable_Property_GUID: TGuid = '{5A43E524-F9A2-4B12-84C8-B48A3EFEDD34}';
  {$EXTERNALSYM IsGridItemPatternAvailable_Property_GUID}
  IsGridPatternAvailable_Property_GUID: TGuid = '{5622C26C-F0EF-4F3B-97CB-714C0868588B}';
  {$EXTERNALSYM IsGridPatternAvailable_Property_GUID}
  IsInvokePatternAvailable_Property_GUID: TGuid = '{4E725738-8364-4679-AA6C-F3F41931F750}';
  {$EXTERNALSYM IsInvokePatternAvailable_Property_GUID}
  IsMultipleViewPatternAvailable_Property_GUID: TGuid = '{FF0A31EB-8E25-469D-8D6E-E771A27C1B90}';
  {$EXTERNALSYM IsMultipleViewPatternAvailable_Property_GUID}
  IsRangeValuePatternAvailable_Property_GUID: TGuid = '{FDA4244A-EB4D-43FF-B5AD-ED36D373EC4C}';
  {$EXTERNALSYM IsRangeValuePatternAvailable_Property_GUID}
  IsScrollPatternAvailable_Property_GUID: TGuid = '{3EBB7B4A-828A-4B57-9D22-2FEA1632ED0D}';
  {$EXTERNALSYM IsScrollPatternAvailable_Property_GUID}
  IsScrollItemPatternAvailable_Property_GUID: TGuid = '{1CAD1A05-0927-4B76-97E1-0FCDB209B98A}';
  {$EXTERNALSYM IsScrollItemPatternAvailable_Property_GUID}
  IsSelectionItemPatternAvailable_Property_GUID: TGuid = '{8BECD62D-0BC3-4109-BEE2-8E6715290E68}';
  {$EXTERNALSYM IsSelectionItemPatternAvailable_Property_GUID}
  IsSelectionPatternAvailable_Property_GUID: TGuid = '{F588ACBE-C769-4838-9A60-2686DC1188C4}';
  {$EXTERNALSYM IsSelectionPatternAvailable_Property_GUID}
  IsTablePatternAvailable_Property_GUID: TGuid = '{CB83575F-45C2-4048-9C76-159715A139DF}';
  {$EXTERNALSYM IsTablePatternAvailable_Property_GUID}
  IsTableItemPatternAvailable_Property_GUID: TGuid = '{EB36B40D-8EA4-489B-A013-E60D5951FE34}';
  {$EXTERNALSYM IsTableItemPatternAvailable_Property_GUID}
  IsTextPatternAvailable_Property_GUID: TGuid = '{FBE2D69D-AFF6-4A45-82E2-FC92A82F5917}';
  {$EXTERNALSYM IsTextPatternAvailable_Property_GUID}
  IsTogglePatternAvailable_Property_GUID: TGuid = '{78686D53-FCD0-4B83-9B78-5832CE63BB5B}';
  {$EXTERNALSYM IsTogglePatternAvailable_Property_GUID}
  IsTransformPatternAvailable_Property_GUID: TGuid = '{A7F78804-D68B-4077-A5C6-7A5EA1AC31C5}';
  {$EXTERNALSYM IsTransformPatternAvailable_Property_GUID}
  IsValuePatternAvailable_Property_GUID: TGuid = '{0B5020A7-2119-473B-BE37-5CEB98BBFB22}';
  {$EXTERNALSYM IsValuePatternAvailable_Property_GUID}
  IsWindowPatternAvailable_Property_GUID: TGuid = '{E7A57BB1-5888-4155-98DC-B422FD57F2BC}';
  {$EXTERNALSYM IsWindowPatternAvailable_Property_GUID}
  IsLegacyIAccessiblePatternAvailable_Property_GUID: TGuid = '{D8EBD0C7-929A-4EE7-8D3A-D3D94413027B}';
  {$EXTERNALSYM IsLegacyIAccessiblePatternAvailable_Property_GUID}
  IsItemContainerPatternAvailable_Property_GUID: TGuid = '{624B5CA7-FE40-4957-A019-20C4CF11920F}';
  {$EXTERNALSYM IsItemContainerPatternAvailable_Property_GUID}
  IsVirtualizedItemPatternAvailable_Property_GUID: TGuid = '{302CB151-2AC8-45D6-977B-D2B3A5A53F20}';
  {$EXTERNALSYM IsVirtualizedItemPatternAvailable_Property_GUID}
  IsSynchronizedInputPatternAvailable_Property_GUID: TGuid = '{75D69CC5-D2BF-4943-876E-B45B62A6CC66}';
  {$EXTERNALSYM IsSynchronizedInputPatternAvailable_Property_GUID}
  IsObjectModelPatternAvailable_Property_GUID: TGuid = '{6B21D89B-2841-412F-8EF2-15CA952318BA}';
  {$EXTERNALSYM IsObjectModelPatternAvailable_Property_GUID}
  IsAnnotationPatternAvailable_Property_GUID: TGuid = '{0B5B3238-6D5C-41B6-BCC4-5E807F6551C4}';
  {$EXTERNALSYM IsAnnotationPatternAvailable_Property_GUID}
  IsTextPattern2Available_Property_GUID: TGuid = '{41CF921D-E3F1-4B22-9C81-E1C3ED331C22}';
  {$EXTERNALSYM IsTextPattern2Available_Property_GUID}
  IsTextEditPatternAvailable_Property_GUID: TGuid = '{7843425C-8B32-484C-9AB5-E3200571FFDA}';
  {$EXTERNALSYM IsTextEditPatternAvailable_Property_GUID}
  IsCustomNavigationPatternAvailable_Property_GUID: TGuid = '{8F8E80D4-2351-48E0-874A-54AA7313889A}';
  {$EXTERNALSYM IsCustomNavigationPatternAvailable_Property_GUID}
  IsStylesPatternAvailable_Property_GUID: TGuid = '{27F353D3-459C-4B59-A490-50611DACAFB5}';
  {$EXTERNALSYM IsStylesPatternAvailable_Property_GUID}
  IsSpreadsheetPatternAvailable_Property_GUID: TGuid = '{6FF43732-E4B4-4555-97BC-ECDBBC4D1888}';
  {$EXTERNALSYM IsSpreadsheetPatternAvailable_Property_GUID}
  IsSpreadsheetItemPatternAvailable_Property_GUID: TGuid = '{9FE79B2A-2F94-43FD-996B-549E316F4ACD}';
  {$EXTERNALSYM IsSpreadsheetItemPatternAvailable_Property_GUID}
  IsTransformPattern2Available_Property_GUID: TGuid = '{25980B4B-BE04-4710-AB4A-FDA31DBD2895}';
  {$EXTERNALSYM IsTransformPattern2Available_Property_GUID}
  IsTextChildPatternAvailable_Property_GUID: TGuid = '{559E65DF-30FF-43B5-B5ED-5B283B80C7E9}';
  {$EXTERNALSYM IsTextChildPatternAvailable_Property_GUID}
  IsDragPatternAvailable_Property_GUID: TGuid = '{E997A7B7-1D39-4CA7-BE0F-277FCF5605CC}';
  {$EXTERNALSYM IsDragPatternAvailable_Property_GUID}
  IsDropTargetPatternAvailable_Property_GUID: TGuid = '{0686B62E-8E19-4AAF-873D-384F6D3B92BE}';
  {$EXTERNALSYM IsDropTargetPatternAvailable_Property_GUID}
  IsStructuredMarkupPatternAvailable_Property_GUID: TGuid = '{B0D4C196-2C0B-489C-B165-A405928C6F3D}';
  {$EXTERNALSYM IsStructuredMarkupPatternAvailable_Property_GUID}
  IsPeripheral_Property_GUID: TGuid = '{DA758276-7ED5-49D4-8E68-ECC9A2D300DD}';
  {$EXTERNALSYM IsPeripheral_Property_GUID}
  PositionInSet_Property_GUID: TGuid = '{33D1DC54-641E-4D76-A6B1-13F341C1F896}';
  {$EXTERNALSYM PositionInSet_Property_GUID}
  SizeOfSet_Property_GUID: TGuid = '{1600D33C-3B9F-4369-9431-AA293F344CF1}';
  {$EXTERNALSYM SizeOfSet_Property_GUID}
  Level_Property_GUID: TGuid = '{242AC529-CD36-400F-AAD9-7876EF3AF627}';
  {$EXTERNALSYM Level_Property_GUID}
  AnnotationTypes_Property_GUID: TGuid = '{64B71F76-53C4-4696-A219-20E940C9A176}';
  {$EXTERNALSYM AnnotationTypes_Property_GUID}
  AnnotationObjects_Property_GUID: TGuid = '{310910C8-7C6E-4F20-BECD-4AAF6D191156}';
  {$EXTERNALSYM AnnotationObjects_Property_GUID}
  LandmarkType_Property_GUID: TGuid = '{454045F2-6F61-49F7-A4F8-B5F0CF82DA1E}';
  {$EXTERNALSYM LandmarkType_Property_GUID}
  LocalizedLandmarkType_Property_GUID: TGuid = '{7AC81980-EAFB-4FB2-BF91-F485BEF5E8E1}';
  {$EXTERNALSYM LocalizedLandmarkType_Property_GUID}
  FullDescription_Property_GUID: TGuid = '{0D4450FF-6AEF-4F33-95DD-7BEFA72A4391}';
  {$EXTERNALSYM FullDescription_Property_GUID}
  Value_Value_Property_GUID: TGuid = '{E95F5E64-269F-4A85-BA99-4092C3EA2986}';
  {$EXTERNALSYM Value_Value_Property_GUID}
  Value_IsReadOnly_Property_GUID: TGuid = '{EB090F30-E24C-4799-A705-0D247BC037F8}';
  {$EXTERNALSYM Value_IsReadOnly_Property_GUID}
  RangeValue_Value_Property_GUID: TGuid = '{131F5D98-C50C-489D-ABE5-AE220898C5F7}';
  {$EXTERNALSYM RangeValue_Value_Property_GUID}
  RangeValue_IsReadOnly_Property_GUID: TGuid = '{25FA1055-DEBF-4373-A79E-1F1A1908D3C4}';
  {$EXTERNALSYM RangeValue_IsReadOnly_Property_GUID}
  RangeValue_Minimum_Property_GUID: TGuid = '{78CBD3B2-684D-4860-AF93-D1F95CB022FD}';
  {$EXTERNALSYM RangeValue_Minimum_Property_GUID}
  RangeValue_Maximum_Property_GUID: TGuid = '{19319914-F979-4B35-A1A6-D37E05433473}';
  {$EXTERNALSYM RangeValue_Maximum_Property_GUID}
  RangeValue_LargeChange_Property_GUID: TGuid = '{A1F96325-3A3D-4B44-8E1F-4A46D9844019}';
  {$EXTERNALSYM RangeValue_LargeChange_Property_GUID}
  RangeValue_SmallChange_Property_GUID: TGuid = '{81C2C457-3941-4107-9975-139760F7C072}';
  {$EXTERNALSYM RangeValue_SmallChange_Property_GUID}
  Scroll_HorizontalScrollPercent_Property_GUID: TGuid = '{C7C13C0E-EB21-47FF-ACC4-B5A3350F5191}';
  {$EXTERNALSYM Scroll_HorizontalScrollPercent_Property_GUID}
  Scroll_HorizontalViewSize_Property_GUID: TGuid = '{70C2E5D4-FCB0-4713-A9AA-AF92FF79E4CD}';
  {$EXTERNALSYM Scroll_HorizontalViewSize_Property_GUID}
  Scroll_VerticalScrollPercent_Property_GUID: TGuid = '{6C8D7099-B2A8-4948-BFF7-3CF9058BFEFB}';
  {$EXTERNALSYM Scroll_VerticalScrollPercent_Property_GUID}
  Scroll_VerticalViewSize_Property_GUID: TGuid = '{DE6A2E22-D8C7-40C5-83BA-E5F681D53108}';
  {$EXTERNALSYM Scroll_VerticalViewSize_Property_GUID}
  Scroll_HorizontallyScrollable_Property_GUID: TGuid = '{8B925147-28CD-49AE-BD63-F44118D2E719}';
  {$EXTERNALSYM Scroll_HorizontallyScrollable_Property_GUID}
  Scroll_VerticallyScrollable_Property_GUID: TGuid = '{89164798-0068-4315-B89A-1E7CFBBC3DFC}';
  {$EXTERNALSYM Scroll_VerticallyScrollable_Property_GUID}
  Selection_Selection_Property_GUID: TGuid = '{AA6DC2A2-0E2B-4D38-96D5-34E470B81853}';
  {$EXTERNALSYM Selection_Selection_Property_GUID}
  Selection_CanSelectMultiple_Property_GUID: TGuid = '{49D73DA5-C883-4500-883D-8FCF8DAF6CBE}';
  {$EXTERNALSYM Selection_CanSelectMultiple_Property_GUID}
  Selection_IsSelectionRequired_Property_GUID: TGuid = '{B1AE4422-63FE-44E7-A5A5-A738C829B19A}';
  {$EXTERNALSYM Selection_IsSelectionRequired_Property_GUID}
  Grid_RowCount_Property_GUID: TGuid = '{2A9505BF-C2EB-4FB6-B356-8245AE53703E}';
  {$EXTERNALSYM Grid_RowCount_Property_GUID}
  Grid_ColumnCount_Property_GUID: TGuid = '{FE96F375-44AA-4536-AC7A-2A75D71A3EFC}';
  {$EXTERNALSYM Grid_ColumnCount_Property_GUID}
  GridItem_Row_Property_GUID: TGuid = '{6223972A-C945-4563-9329-FDC974AF2553}';
  {$EXTERNALSYM GridItem_Row_Property_GUID}
  GridItem_Column_Property_GUID: TGuid = '{C774C15C-62C0-4519-8BDC-47BE573C8AD5}';
  {$EXTERNALSYM GridItem_Column_Property_GUID}
  GridItem_RowSpan_Property_GUID: TGuid = '{4582291C-466B-4E93-8E83-3D1715EC0C5E}';
  {$EXTERNALSYM GridItem_RowSpan_Property_GUID}
  GridItem_ColumnSpan_Property_GUID: TGuid = '{583EA3F5-86D0-4B08-A6EC-2C5463FFC109}';
  {$EXTERNALSYM GridItem_ColumnSpan_Property_GUID}
  GridItem_Parent_Property_GUID: TGuid = '{9D912252-B97F-4ECC-8510-EA0E33427C72}';
  {$EXTERNALSYM GridItem_Parent_Property_GUID}
  Dock_DockPosition_Property_GUID: TGuid = '{6D67F02E-C0B0-4B10-B5B9-18D6ECF98760}';
  {$EXTERNALSYM Dock_DockPosition_Property_GUID}
  ExpandCollapse_ExpandCollapseState_Property_GUID: TGuid = '{275A4C48-85A7-4F69-ABA0-AF157610002B}';
  {$EXTERNALSYM ExpandCollapse_ExpandCollapseState_Property_GUID}
  MultipleView_CurrentView_Property_GUID: TGuid = '{7A81A67A-B94F-4875-918B-65C8D2F998E5}';
  {$EXTERNALSYM MultipleView_CurrentView_Property_GUID}
  MultipleView_SupportedViews_Property_GUID: TGuid = '{8D5DB9FD-CE3C-4AE7-B788-400A3C645547}';
  {$EXTERNALSYM MultipleView_SupportedViews_Property_GUID}
  Window_CanMaximize_Property_GUID: TGuid = '{64FFF53F-635D-41C1-950C-CB5ADFBE28E3}';
  {$EXTERNALSYM Window_CanMaximize_Property_GUID}
  Window_CanMinimize_Property_GUID: TGuid = '{B73B4625-5988-4B97-B4C2-A6FE6E78C8C6}';
  {$EXTERNALSYM Window_CanMinimize_Property_GUID}
  Window_WindowVisualState_Property_GUID: TGuid = '{4AB7905F-E860-453E-A30A-F6431E5DAAD5}';
  {$EXTERNALSYM Window_WindowVisualState_Property_GUID}
  Window_WindowInteractionState_Property_GUID: TGuid = '{4FED26A4-0455-4FA2-B21C-C4DA2DB1FF9C}';
  {$EXTERNALSYM Window_WindowInteractionState_Property_GUID}
  Window_IsModal_Property_GUID: TGuid = '{FF4E6892-37B9-4FCA-8532-FFE674ECFEED}';
  {$EXTERNALSYM Window_IsModal_Property_GUID}
  Window_IsTopmost_Property_GUID: TGuid = '{EF7D85D3-0937-4962-9241-B62345F24041}';
  {$EXTERNALSYM Window_IsTopmost_Property_GUID}
  SelectionItem_IsSelected_Property_GUID: TGuid = '{F122835F-CD5F-43DF-B79D-4B849E9E6020}';
  {$EXTERNALSYM SelectionItem_IsSelected_Property_GUID}
  SelectionItem_SelectionContainer_Property_GUID: TGuid = '{A4365B6E-9C1E-4B63-8B53-C2421DD1E8FB}';
  {$EXTERNALSYM SelectionItem_SelectionContainer_Property_GUID}
  Table_RowHeaders_Property_GUID: TGuid = '{D9E35B87-6EB8-4562-AAC6-A8A9075236A8}';
  {$EXTERNALSYM Table_RowHeaders_Property_GUID}
  Table_ColumnHeaders_Property_GUID: TGuid = '{AFF1D72B-968D-42B1-B459-150B299DA664}';
  {$EXTERNALSYM Table_ColumnHeaders_Property_GUID}
  Table_RowOrColumnMajor_Property_GUID: TGuid = '{83BE75C3-29FE-4A30-85E1-2A6277FD106E}';
  {$EXTERNALSYM Table_RowOrColumnMajor_Property_GUID}
  TableItem_RowHeaderItems_Property_GUID: TGuid = '{B3F853A0-0574-4CD8-BCD7-ED5923572D97}';
  {$EXTERNALSYM TableItem_RowHeaderItems_Property_GUID}
  TableItem_ColumnHeaderItems_Property_GUID: TGuid = '{967A56A3-74B6-431E-8DE6-99C411031C58}';
  {$EXTERNALSYM TableItem_ColumnHeaderItems_Property_GUID}
  Toggle_ToggleState_Property_GUID: TGuid = '{B23CDC52-22C2-4C6C-9DED-F5C422479EDE}';
  {$EXTERNALSYM Toggle_ToggleState_Property_GUID}
  Transform_CanMove_Property_GUID: TGuid = '{1B75824D-208B-4FDF-BCCD-F1F4E5741F4F}';
  {$EXTERNALSYM Transform_CanMove_Property_GUID}
  Transform_CanResize_Property_GUID: TGuid = '{BB98DCA5-4C1A-41D4-A4F6-EBC128644180}';
  {$EXTERNALSYM Transform_CanResize_Property_GUID}
  Transform_CanRotate_Property_GUID: TGuid = '{10079B48-3849-476F-AC96-44A95C8440D9}';
  {$EXTERNALSYM Transform_CanRotate_Property_GUID}
  LegacyIAccessible_ChildId_Property_GUID: TGuid = '{9A191B5D-9EF2-4787-A459-DCDE885DD4E8}';
  {$EXTERNALSYM LegacyIAccessible_ChildId_Property_GUID}
  LegacyIAccessible_Name_Property_GUID: TGuid = '{CAEB063D-40AE-4869-AA5A-1B8E5D666739}';
  {$EXTERNALSYM LegacyIAccessible_Name_Property_GUID}
  LegacyIAccessible_Value_Property_GUID: TGuid = '{B5C5B0B6-8217-4A77-97A5-190A85ED0156}';
  {$EXTERNALSYM LegacyIAccessible_Value_Property_GUID}
  LegacyIAccessible_Description_Property_GUID: TGuid = '{46448418-7D70-4EA9-9D27-B7E775CF2AD7}';
  {$EXTERNALSYM LegacyIAccessible_Description_Property_GUID}
  LegacyIAccessible_Role_Property_GUID: TGuid = '{6856E59F-CBAF-4E31-93E8-BCBF6F7E491C}';
  {$EXTERNALSYM LegacyIAccessible_Role_Property_GUID}
  LegacyIAccessible_State_Property_GUID: TGuid = '{DF985854-2281-4340-AB9C-C60E2C5803F6}';
  {$EXTERNALSYM LegacyIAccessible_State_Property_GUID}
  LegacyIAccessible_Help_Property_GUID: TGuid = '{94402352-161C-4B77-A98D-A872CC33947A}';
  {$EXTERNALSYM LegacyIAccessible_Help_Property_GUID}
  LegacyIAccessible_KeyboardShortcut_Property_GUID: TGuid = '{8F6909AC-00B8-4259-A41C-966266D43A8A}';
  {$EXTERNALSYM LegacyIAccessible_KeyboardShortcut_Property_GUID}
  LegacyIAccessible_Selection_Property_GUID: TGuid = '{8AA8B1E0-0891-40CC-8B06-90D7D4166219}';
  {$EXTERNALSYM LegacyIAccessible_Selection_Property_GUID}
  LegacyIAccessible_DefaultAction_Property_GUID: TGuid = '{3B331729-EAAD-4502-B85F-92615622913C}';
  {$EXTERNALSYM LegacyIAccessible_DefaultAction_Property_GUID}
  Annotation_AnnotationTypeId_Property_GUID: TGuid = '{20AE484F-69EF-4C48-8F5B-C4938B206AC7}';
  {$EXTERNALSYM Annotation_AnnotationTypeId_Property_GUID}
  Annotation_AnnotationTypeName_Property_GUID: TGuid = '{9B818892-5AC9-4AF9-AA96-F58A77B058E3}';
  {$EXTERNALSYM Annotation_AnnotationTypeName_Property_GUID}
  Annotation_Author_Property_GUID: TGuid = '{7A528462-9C5C-4A03-A974-8B307A9937F2}';
  {$EXTERNALSYM Annotation_Author_Property_GUID}
  Annotation_DateTime_Property_GUID: TGuid = '{99B5CA5D-1ACF-414B-A4D0-6B350B047578}';
  {$EXTERNALSYM Annotation_DateTime_Property_GUID}
  Annotation_Target_Property_GUID: TGuid = '{B71B302D-2104-44AD-9C5C-092B4907D70F}';
  {$EXTERNALSYM Annotation_Target_Property_GUID}
  Styles_StyleId_Property_GUID: TGuid = '{DA82852F-3817-4233-82AF-02279E72CC77}';
  {$EXTERNALSYM Styles_StyleId_Property_GUID}
  Styles_StyleName_Property_GUID: TGuid = '{1C12B035-05D1-4F55-9E8E-1489F3FF550D}';
  {$EXTERNALSYM Styles_StyleName_Property_GUID}
  Styles_FillColor_Property_GUID: TGuid = '{63EFF97A-A1C5-4B1D-84EB-B765F2EDD632}';
  {$EXTERNALSYM Styles_FillColor_Property_GUID}
  Styles_FillPatternStyle_Property_GUID: TGuid = '{81CF651F-482B-4451-A30A-E1545E554FB8}';
  {$EXTERNALSYM Styles_FillPatternStyle_Property_GUID}
  Styles_Shape_Property_GUID: TGuid = '{C71A23F8-778C-400D-8458-3B543E526984}';
  {$EXTERNALSYM Styles_Shape_Property_GUID}
  Styles_FillPatternColor_Property_GUID: TGuid = '{939A59FE-8FBD-4E75-A271-AC4595195163}';
  {$EXTERNALSYM Styles_FillPatternColor_Property_GUID}
  Styles_ExtendedProperties_Property_GUID: TGuid = '{F451CDA0-BA0A-4681-B0B0-0DBDB53E58F3}';
  {$EXTERNALSYM Styles_ExtendedProperties_Property_GUID}
  SpreadsheetItem_Formula_Property_GUID: TGuid = '{E602E47D-1B47-4BEA-87CF-3B0B0B5C15B6}';
  {$EXTERNALSYM SpreadsheetItem_Formula_Property_GUID}
  SpreadsheetItem_AnnotationObjects_Property_GUID: TGuid = '{A3194C38-C9BC-4604-9396-AE3F9F457F7B}';
  {$EXTERNALSYM SpreadsheetItem_AnnotationObjects_Property_GUID}
  SpreadsheetItem_AnnotationTypes_Property_GUID: TGuid = '{C70C51D0-D602-4B45-AFBC-B4712B96D72B}';
  {$EXTERNALSYM SpreadsheetItem_AnnotationTypes_Property_GUID}
  Transform2_CanZoom_Property_GUID: TGuid = '{F357E890-A756-4359-9CA6-86702BF8F381}';
  {$EXTERNALSYM Transform2_CanZoom_Property_GUID}
  LiveSetting_Property_GUID: TGuid = '{C12BCD8E-2A8E-4950-8AE7-3625111D58EB}';
  {$EXTERNALSYM LiveSetting_Property_GUID}
  Drag_IsGrabbed_Property_GUID: TGuid = '{45F206F3-75CC-4CCA-A9B9-FCDFB982D8A2}';
  {$EXTERNALSYM Drag_IsGrabbed_Property_GUID}
  Drag_GrabbedItems_Property_GUID: TGuid = '{77C1562C-7B86-4B21-9ED7-3CEFDA6F4C43}';
  {$EXTERNALSYM Drag_GrabbedItems_Property_GUID}
  Drag_DropEffect_Property_GUID: TGuid = '{646F2779-48D3-4B23-8902-4BF100005DF3}';
  {$EXTERNALSYM Drag_DropEffect_Property_GUID}
  Drag_DropEffects_Property_GUID: TGuid = '{F5D61156-7CE6-49BE-A836-9269DCEC920F}';
  {$EXTERNALSYM Drag_DropEffects_Property_GUID}
  DropTarget_DropTargetEffect_Property_GUID: TGuid = '{8BB75975-A0CA-4981-B818-87FC66E9509D}';
  {$EXTERNALSYM DropTarget_DropTargetEffect_Property_GUID}
  DropTarget_DropTargetEffects_Property_GUID: TGuid = '{BC1DD4ED-CB89-45F1-A592-E03B08AE790F}';
  {$EXTERNALSYM DropTarget_DropTargetEffects_Property_GUID}
  Transform2_ZoomLevel_Property_GUID: TGuid = '{EEE29F1A-F4A2-4B5B-AC65-95CF93283387}';
  {$EXTERNALSYM Transform2_ZoomLevel_Property_GUID}
  Transform2_ZoomMinimum_Property_GUID: TGuid = '{742CCC16-4AD1-4E07-96FE-B122C6E6B22B}';
  {$EXTERNALSYM Transform2_ZoomMinimum_Property_GUID}
  Transform2_ZoomMaximum_Property_GUID: TGuid = '{42AB6B77-CEB0-4ECA-B82A-6CFA5FA1FC08}';
  {$EXTERNALSYM Transform2_ZoomMaximum_Property_GUID}
  FlowsFrom_Property_GUID: TGuid = '{05C6844F-19DE-48F8-95FA-880D5B0FD615}';
  {$EXTERNALSYM FlowsFrom_Property_GUID}
  FillColor_Property_GUID: TGuid = '{6E0EC4D0-E2A8-4A56-9DE7-953389933B39}';
  {$EXTERNALSYM FillColor_Property_GUID}
  OutlineColor_Property_GUID: TGuid = '{C395D6C0-4B55-4762-A073-FD303A634F52}';
  {$EXTERNALSYM OutlineColor_Property_GUID}
  FillType_Property_GUID: TGuid = '{C6FC74E4-8CB9-429C-A9E1-9BC4AC372B62}';
  {$EXTERNALSYM FillType_Property_GUID}
  VisualEffects_Property_GUID: TGuid = '{E61A8565-AAD9-46D7-9E70-4E8A8420D420}';
  {$EXTERNALSYM VisualEffects_Property_GUID}
  OutlineThickness_Property_GUID: TGuid = '{13E67CC7-DAC2-4888-BDD3-375C62FA9618}';
  {$EXTERNALSYM OutlineThickness_Property_GUID}
  CenterPoint_Property_GUID: TGuid = '{0CB00C08-540C-4EDB-9445-26359EA69785}';
  {$EXTERNALSYM CenterPoint_Property_GUID}
  Rotation_Property_GUID: TGuid = '{767CDC7D-AEC0-4110-AD32-30EDD403492E}';
  {$EXTERNALSYM Rotation_Property_GUID}
  Size_Property_GUID: TGuid = '{2B5F761D-F885-4404-973F-9B1D98E36D8F}';
  {$EXTERNALSYM Size_Property_GUID}
  ToolTipOpened_Event_GUID: TGuid = '{3F4B97FF-2EDC-451D-BCA4-95A3188D5B03}';
  {$EXTERNALSYM ToolTipOpened_Event_GUID}
  ToolTipClosed_Event_GUID: TGuid = '{276D71EF-24A9-49B6-8E97-DA98B401BBCD}';
  {$EXTERNALSYM ToolTipClosed_Event_GUID}
  StructureChanged_Event_GUID: TGuid = '{59977961-3EDD-4B11-B13B-676B2A2A6CA9}';
  {$EXTERNALSYM StructureChanged_Event_GUID}
  MenuOpened_Event_GUID: TGuid = '{EBE2E945-66CA-4ED1-9FF8-2AD7DF0A1B08}';
  {$EXTERNALSYM MenuOpened_Event_GUID}
  AutomationPropertyChanged_Event_GUID: TGuid = '{2527FBA1-8D7A-4630-A4CC-E66315942F52}';
  {$EXTERNALSYM AutomationPropertyChanged_Event_GUID}
  AutomationFocusChanged_Event_GUID: TGuid = '{B68A1F17-F60D-41A7-A3CC-B05292155FE0}';
  {$EXTERNALSYM AutomationFocusChanged_Event_GUID}
  ActiveTextPositionChanged_Event_GUID: TGuid = '{A5C09E9C-C77D-4F25-B491-E5BB7017CBD4}';
  {$EXTERNALSYM ActiveTextPositionChanged_Event_GUID}
  AsyncContentLoaded_Event_GUID: TGuid = '{5FDEE11C-D2FA-4FB9-904E-5CBEE894D5EF}';
  {$EXTERNALSYM AsyncContentLoaded_Event_GUID}
  MenuClosed_Event_GUID: TGuid = '{3CF1266E-1582-4041-ACD7-88A35A965297}';
  {$EXTERNALSYM MenuClosed_Event_GUID}
  LayoutInvalidated_Event_GUID: TGuid = '{ED7D6544-A6BD-4595-9BAE-3D28946CC715}';
  {$EXTERNALSYM LayoutInvalidated_Event_GUID}
  Invoke_Invoked_Event_GUID: TGuid = '{DFD699F0-C915-49DD-B422-DDE785C3D24B}';
  {$EXTERNALSYM Invoke_Invoked_Event_GUID}
  SelectionItem_ElementAddedToSelectionEvent_Event_GUID: TGuid = '{3C822DD1-C407-4DBA-91DD-79D4AED0AEC6}';
  {$EXTERNALSYM SelectionItem_ElementAddedToSelectionEvent_Event_GUID}
  SelectionItem_ElementRemovedFromSelectionEvent_Event_GUID: TGuid = '{097FA8A9-7079-41AF-8B9C-0934D8305E5C}';
  {$EXTERNALSYM SelectionItem_ElementRemovedFromSelectionEvent_Event_GUID}
  SelectionItem_ElementSelectedEvent_Event_GUID: TGuid = '{B9C7DBFB-4EBE-4532-AAF4-008CF647233C}';
  {$EXTERNALSYM SelectionItem_ElementSelectedEvent_Event_GUID}
  Selection_InvalidatedEvent_Event_GUID: TGuid = '{CAC14904-16B4-4B53-8E47-4CB1DF267BB7}';
  {$EXTERNALSYM Selection_InvalidatedEvent_Event_GUID}
  Text_TextSelectionChangedEvent_Event_GUID: TGuid = '{918EDAA1-71B3-49AE-9741-79BEB8D358F3}';
  {$EXTERNALSYM Text_TextSelectionChangedEvent_Event_GUID}
  Text_TextChangedEvent_Event_GUID: TGuid = '{4A342082-F483-48C4-AC11-A84B435E2A84}';
  {$EXTERNALSYM Text_TextChangedEvent_Event_GUID}
  Window_WindowOpened_Event_GUID: TGuid = '{D3E81D06-DE45-4F2F-9633-DE9E02FB65AF}';
  {$EXTERNALSYM Window_WindowOpened_Event_GUID}
  Window_WindowClosed_Event_GUID: TGuid = '{EDF141F8-FA67-4E22-BBF7-944E05735EE2}';
  {$EXTERNALSYM Window_WindowClosed_Event_GUID}
  MenuModeStart_Event_GUID: TGuid = '{18D7C631-166A-4AC9-AE3B-EF4B5420E681}';
  {$EXTERNALSYM MenuModeStart_Event_GUID}
  MenuModeEnd_Event_GUID: TGuid = '{9ECD4C9F-80DD-47B8-8267-5AEC06BB2CFF}';
  {$EXTERNALSYM MenuModeEnd_Event_GUID}
  InputReachedTarget_Event_GUID: TGuid = '{93ED549A-0549-40F0-BEDB-28E44F7DE2A3}';
  {$EXTERNALSYM InputReachedTarget_Event_GUID}
  InputReachedOtherElement_Event_GUID: TGuid = '{ED201D8A-4E6C-415E-A874-2460C9B66BA8}';
  {$EXTERNALSYM InputReachedOtherElement_Event_GUID}
  InputDiscarded_Event_GUID: TGuid = '{7F36C367-7B18-417C-97E3-9D58DDC944AB}';
  {$EXTERNALSYM InputDiscarded_Event_GUID}
  SystemAlert_Event_GUID: TGuid = '{D271545D-7A3A-47A7-8474-81D29A2451C9}';
  {$EXTERNALSYM SystemAlert_Event_GUID}
  LiveRegionChanged_Event_GUID: TGuid = '{102D5E90-E6A9-41B6-B1C5-A9B1929D9510}';
  {$EXTERNALSYM LiveRegionChanged_Event_GUID}
  HostedFragmentRootsInvalidated_Event_GUID: TGuid = '{E6BDB03E-0921-4EC5-8DCF-EAE877B0426B}';
  {$EXTERNALSYM HostedFragmentRootsInvalidated_Event_GUID}
  Drag_DragStart_Event_GUID: TGuid = '{883A480B-3AA9-429D-95E4-D9C8D011F0DD}';
  {$EXTERNALSYM Drag_DragStart_Event_GUID}
  Drag_DragCancel_Event_GUID: TGuid = '{C3EDE6FA-3451-4E0F-9E71-DF9C280A4657}';
  {$EXTERNALSYM Drag_DragCancel_Event_GUID}
  Drag_DragComplete_Event_GUID: TGuid = '{38E96188-EF1F-463E-91CA-3A7792C29CAF}';
  {$EXTERNALSYM Drag_DragComplete_Event_GUID}
  DropTarget_DragEnter_Event_GUID: TGuid = '{AAD9319B-032C-4A88-961D-1CF579581E34}';
  {$EXTERNALSYM DropTarget_DragEnter_Event_GUID}
  DropTarget_DragLeave_Event_GUID: TGuid = '{0F82EB15-24A2-4988-9217-DE162AEE272B}';
  {$EXTERNALSYM DropTarget_DragLeave_Event_GUID}
  DropTarget_Dropped_Event_GUID: TGuid = '{622CEAD8-1EDB-4A3D-ABBC-BE2211FF68B5}';
  {$EXTERNALSYM DropTarget_Dropped_Event_GUID}
  StructuredMarkup_CompositionComplete_Event_GUID: TGuid = '{C48A3C17-677A-4047-A68D-FC1257528AEF}';
  {$EXTERNALSYM StructuredMarkup_CompositionComplete_Event_GUID}
  StructuredMarkup_Deleted_Event_GUID: TGuid = '{F9D0A020-E1C1-4ECF-B9AA-52EFDE7E41E1}';
  {$EXTERNALSYM StructuredMarkup_Deleted_Event_GUID}
  StructuredMarkup_SelectionChanged_Event_GUID: TGuid = '{A7C815F7-FF9F-41C7-A3A7-AB6CBFDB4903}';
  {$EXTERNALSYM StructuredMarkup_SelectionChanged_Event_GUID}
  Invoke_Pattern_GUID: TGuid = '{D976C2FC-66EA-4A6E-B28F-C24C7546AD37}';
  {$EXTERNALSYM Invoke_Pattern_GUID}
  Selection_Pattern_GUID: TGuid = '{66E3B7E8-D821-4D25-8761-435D2C8B253F}';
  {$EXTERNALSYM Selection_Pattern_GUID}
  Value_Pattern_GUID: TGuid = '{17FAAD9E-C877-475B-B933-77332779B637}';
  {$EXTERNALSYM Value_Pattern_GUID}
  RangeValue_Pattern_GUID: TGuid = '{18B00D87-B1C9-476A-BFBD-5F0BDB926F63}';
  {$EXTERNALSYM RangeValue_Pattern_GUID}
  Scroll_Pattern_GUID: TGuid = '{895FA4B4-759D-4C50-8E15-03460672003C}';
  {$EXTERNALSYM Scroll_Pattern_GUID}
  ExpandCollapse_Pattern_GUID: TGuid = '{AE05EFA2-F9D1-428A-834C-53A5C52F9B8B}';
  {$EXTERNALSYM ExpandCollapse_Pattern_GUID}
  Grid_Pattern_GUID: TGuid = '{260A2CCB-93A8-4E44-A4C1-3DF397F2B02B}';
  {$EXTERNALSYM Grid_Pattern_GUID}
  GridItem_Pattern_GUID: TGuid = '{F2D5C877-A462-4957-A2A5-2C96B303BC63}';
  {$EXTERNALSYM GridItem_Pattern_GUID}
  MultipleView_Pattern_GUID: TGuid = '{547A6AE4-113F-47C4-850F-DB4DFA466B1D}';
  {$EXTERNALSYM MultipleView_Pattern_GUID}
  Window_Pattern_GUID: TGuid = '{27901735-C760-4994-AD11-5919E606B110}';
  {$EXTERNALSYM Window_Pattern_GUID}
  SelectionItem_Pattern_GUID: TGuid = '{9BC64EEB-87C7-4B28-94BB-4D9FA437B6EF}';
  {$EXTERNALSYM SelectionItem_Pattern_GUID}
  Dock_Pattern_GUID: TGuid = '{9CBAA846-83C8-428D-827F-7E6063FE0620}';
  {$EXTERNALSYM Dock_Pattern_GUID}
  Table_Pattern_GUID: TGuid = '{C415218E-A028-461E-AA92-8F925CF79351}';
  {$EXTERNALSYM Table_Pattern_GUID}
  TableItem_Pattern_GUID: TGuid = '{DF1343BD-1888-4A29-A50C-B92E6DE37F6F}';
  {$EXTERNALSYM TableItem_Pattern_GUID}
  Text_Pattern_GUID: TGuid = '{8615F05D-7DE5-44FD-A679-2CA4B46033A8}';
  {$EXTERNALSYM Text_Pattern_GUID}
  Toggle_Pattern_GUID: TGuid = '{0B419760-E2F4-43FF-8C5F-9457C82B56E9}';
  {$EXTERNALSYM Toggle_Pattern_GUID}
  Transform_Pattern_GUID: TGuid = '{24B46FDB-587E-49F1-9C4A-D8E98B664B7B}';
  {$EXTERNALSYM Transform_Pattern_GUID}
  ScrollItem_Pattern_GUID: TGuid = '{4591D005-A803-4D5C-B4D5-8D2800F906A7}';
  {$EXTERNALSYM ScrollItem_Pattern_GUID}
  LegacyIAccessible_Pattern_GUID: TGuid = '{54CC0A9F-3395-48AF-BA8D-73F85690F3E0}';
  {$EXTERNALSYM LegacyIAccessible_Pattern_GUID}
  ItemContainer_Pattern_GUID: TGuid = '{3D13DA0F-8B9A-4A99-85FA-C5C9A69F1ED4}';
  {$EXTERNALSYM ItemContainer_Pattern_GUID}
  VirtualizedItem_Pattern_GUID: TGuid = '{F510173E-2E71-45E9-A6E5-62F6ED8289D5}';
  {$EXTERNALSYM VirtualizedItem_Pattern_GUID}
  SynchronizedInput_Pattern_GUID: TGuid = '{05C288A6-C47B-488B-B653-33977A551B8B}';
  {$EXTERNALSYM SynchronizedInput_Pattern_GUID}
  ObjectModel_Pattern_GUID: TGuid = '{3E04ACFE-08FC-47EC-96BC-353FA3B34AA7}';
  {$EXTERNALSYM ObjectModel_Pattern_GUID}
  Annotation_Pattern_GUID: TGuid = '{F6C72AD7-356C-4850-9291-316F608A8C84}';
  {$EXTERNALSYM Annotation_Pattern_GUID}
  Text_Pattern2_GUID: TGuid = '{498479A2-5B22-448D-B6E4-647490860698}';
  {$EXTERNALSYM Text_Pattern2_GUID}
  TextEdit_Pattern_GUID: TGuid = '{69F3FF89-5AF9-4C75-9340-F2DE292E4591}';
  {$EXTERNALSYM TextEdit_Pattern_GUID}
  CustomNavigation_Pattern_GUID: TGuid = '{AFEA938A-621E-4054-BB2C-2F46114DAC3F}';
  {$EXTERNALSYM CustomNavigation_Pattern_GUID}
  Styles_Pattern_GUID: TGuid = '{1AE62655-DA72-4D60-A153-E5AA6988E3BF}';
  {$EXTERNALSYM Styles_Pattern_GUID}
  Spreadsheet_Pattern_GUID: TGuid = '{6A5B24C9-9D1E-4B85-9E44-C02E3169B10B}';
  {$EXTERNALSYM Spreadsheet_Pattern_GUID}
  SpreadsheetItem_Pattern_GUID: TGuid = '{32CF83FF-F1A8-4A8C-8658-D47BA74E20BA}';
  {$EXTERNALSYM SpreadsheetItem_Pattern_GUID}
  Tranform_Pattern2_GUID: TGuid = '{8AFCFD07-A369-44DE-988B-2F7FF49FB8A8}';
  {$EXTERNALSYM Tranform_Pattern2_GUID}
  TextChild_Pattern_GUID: TGuid = '{7533CAB7-3BFE-41EF-9E85-E2638CBE169E}';
  {$EXTERNALSYM TextChild_Pattern_GUID}
  Drag_Pattern_GUID: TGuid = '{C0BEE21F-CCB3-4FED-995B-114F6E3D2728}';
  {$EXTERNALSYM Drag_Pattern_GUID}
  DropTarget_Pattern_GUID: TGuid = '{0BCBEC56-BD34-4B7B-9FD5-2659905EA3DC}';
  {$EXTERNALSYM DropTarget_Pattern_GUID}
  StructuredMarkup_Pattern_GUID: TGuid = '{ABBD0878-8665-4F5C-94FC-36E7D8BB706B}';
  {$EXTERNALSYM StructuredMarkup_Pattern_GUID}
  Button_Control_GUID: TGuid = '{5A78E369-C6A1-4F33-A9D7-79F20D0C788E}';
  {$EXTERNALSYM Button_Control_GUID}
  Calendar_Control_GUID: TGuid = '{8913EB88-00E5-46BC-8E4E-14A786E165A1}';
  {$EXTERNALSYM Calendar_Control_GUID}
  CheckBox_Control_GUID: TGuid = '{FB50F922-A3DB-49C0-8BC3-06DAD55778E2}';
  {$EXTERNALSYM CheckBox_Control_GUID}
  ComboBox_Control_GUID: TGuid = '{54CB426C-2F33-4FFF-AAA1-AEF60DAC5DEB}';
  {$EXTERNALSYM ComboBox_Control_GUID}
  Edit_Control_GUID: TGuid = '{6504A5C8-2C86-4F87-AE7B-1ABDDC810CF9}';
  {$EXTERNALSYM Edit_Control_GUID}
  Hyperlink_Control_GUID: TGuid = '{8A56022C-B00D-4D15-8FF0-5B6B266E5E02}';
  {$EXTERNALSYM Hyperlink_Control_GUID}
  Image_Control_GUID: TGuid = '{2D3736E4-6B16-4C57-A962-F93260A75243}';
  {$EXTERNALSYM Image_Control_GUID}
  ListItem_Control_GUID: TGuid = '{7B3717F2-44D1-4A58-98A8-F12A9B8F78E2}';
  {$EXTERNALSYM ListItem_Control_GUID}
  List_Control_GUID: TGuid = '{9B149EE1-7CCA-4CFC-9AF1-CAC7BDDD3031}';
  {$EXTERNALSYM List_Control_GUID}
  Menu_Control_GUID: TGuid = '{2E9B1440-0EA8-41FD-B374-C1EA6F503CD1}';
  {$EXTERNALSYM Menu_Control_GUID}
  MenuBar_Control_GUID: TGuid = '{CC384250-0E7B-4AE8-95AE-A08F261B52EE}';
  {$EXTERNALSYM MenuBar_Control_GUID}
  MenuItem_Control_GUID: TGuid = '{F45225D3-D0A0-49D8-9834-9A000D2AEDDC}';
  {$EXTERNALSYM MenuItem_Control_GUID}
  ProgressBar_Control_GUID: TGuid = '{228C9F86-C36C-47BB-9FB6-A5834BFC53A4}';
  {$EXTERNALSYM ProgressBar_Control_GUID}
  RadioButton_Control_GUID: TGuid = '{3BDB49DB-FE2C-4483-B3E1-E57F219440C6}';
  {$EXTERNALSYM RadioButton_Control_GUID}
  ScrollBar_Control_GUID: TGuid = '{DAF34B36-5065-4946-B22F-92595FC0751A}';
  {$EXTERNALSYM ScrollBar_Control_GUID}
  Slider_Control_GUID: TGuid = '{B033C24B-3B35-4CEA-B609-763682FA660B}';
  {$EXTERNALSYM Slider_Control_GUID}
  Spinner_Control_GUID: TGuid = '{60CC4B38-3CB1-4161-B442-C6B726C17825}';
  {$EXTERNALSYM Spinner_Control_GUID}
  StatusBar_Control_GUID: TGuid = '{D45E7D1B-5873-475F-95A4-0433E1F1B00A}';
  {$EXTERNALSYM StatusBar_Control_GUID}
  Tab_Control_GUID: TGuid = '{38CD1F2D-337A-4BD2-A5E3-ADB469E30BD3}';
  {$EXTERNALSYM Tab_Control_GUID}
  TabItem_Control_GUID: TGuid = '{2C6A634F-921B-4E6E-B26E-08FCB0798F4C}';
  {$EXTERNALSYM TabItem_Control_GUID}
  Text_Control_GUID: TGuid = '{AE9772DC-D331-4F09-BE20-7E6DFAF07B0A}';
  {$EXTERNALSYM Text_Control_GUID}
  ToolBar_Control_GUID: TGuid = '{8F06B751-E182-4E98-8893-2284543A7DCE}';
  {$EXTERNALSYM ToolBar_Control_GUID}
  ToolTip_Control_GUID: TGuid = '{05DDC6D1-2137-4768-98EA-73F52F7134F3}';
  {$EXTERNALSYM ToolTip_Control_GUID}
  Tree_Control_GUID: TGuid = '{7561349C-D241-43F4-9908-B5F091BEE611}';
  {$EXTERNALSYM Tree_Control_GUID}
  TreeItem_Control_GUID: TGuid = '{62C9FEB9-8FFC-4878-A3A4-96B030315C18}';
  {$EXTERNALSYM TreeItem_Control_GUID}
  Custom_Control_GUID: TGuid = '{F29EA0C3-ADB7-430A-BA90-E52C7313E6ED}';
  {$EXTERNALSYM Custom_Control_GUID}
  Group_Control_GUID: TGuid = '{AD50AA1C-E8C8-4774-AE1B-DD86DF0B3BDC}';
  {$EXTERNALSYM Group_Control_GUID}
  Thumb_Control_GUID: TGuid = '{701CA877-E310-4DD6-B644-797E4FAEA213}';
  {$EXTERNALSYM Thumb_Control_GUID}
  DataGrid_Control_GUID: TGuid = '{84B783AF-D103-4B0A-8415-E73942410F4B}';
  {$EXTERNALSYM DataGrid_Control_GUID}
  DataItem_Control_GUID: TGuid = '{A0177842-D94F-42A5-814B-6068ADDC8DA5}';
  {$EXTERNALSYM DataItem_Control_GUID}
  Document_Control_GUID: TGuid = '{3CD6BB6F-6F08-4562-B229-E4E2FC7A9EB4}';
  {$EXTERNALSYM Document_Control_GUID}
  SplitButton_Control_GUID: TGuid = '{7011F01F-4ACE-4901-B461-920A6F1CA650}';
  {$EXTERNALSYM SplitButton_Control_GUID}
  Window_Control_GUID: TGuid = '{E13A7242-F462-4F4D-AEC1-53B28D6C3290}';
  {$EXTERNALSYM Window_Control_GUID}
  Pane_Control_GUID: TGuid = '{5C2B3F5B-9182-42A3-8DEC-8C04C1EE634D}';
  {$EXTERNALSYM Pane_Control_GUID}
  Header_Control_GUID: TGuid = '{5B90CBCE-78FB-4614-82B6-554D74718E67}';
  {$EXTERNALSYM Header_Control_GUID}
  HeaderItem_Control_GUID: TGuid = '{E6BC12CB-7C8E-49CF-B168-4A93A32BEBB0}';
  {$EXTERNALSYM HeaderItem_Control_GUID}
  Table_Control_GUID: TGuid = '{773BFA0E-5BC4-4DEB-921B-DE7B3206229E}';
  {$EXTERNALSYM Table_Control_GUID}
  TitleBar_Control_GUID: TGuid = '{98AA55BF-3BB0-4B65-836E-2EA30DBC171F}';
  {$EXTERNALSYM TitleBar_Control_GUID}
  Separator_Control_GUID: TGuid = '{8767EBA3-2A63-4AB0-AC8D-AA50E23DE978}';
  {$EXTERNALSYM Separator_Control_GUID}
  SemanticZoom_Control_GUID: TGuid = '{5FD34A43-061E-42C8-B589-9DCCF74BC43A}';
  {$EXTERNALSYM SemanticZoom_Control_GUID}
  AppBar_Control_GUID: TGuid = '{6114908D-CC02-4D37-875B-B530C7139554}';
  {$EXTERNALSYM AppBar_Control_GUID}
  Text_AnimationStyle_Attribute_GUID: TGuid = '{628209F0-7C9A-4D57-BE64-1F1836571FF5}';
  {$EXTERNALSYM Text_AnimationStyle_Attribute_GUID}
  Text_BackgroundColor_Attribute_GUID: TGuid = '{FDC49A07-583D-4F17-AD27-77FC832A3C0B}';
  {$EXTERNALSYM Text_BackgroundColor_Attribute_GUID}
  Text_BulletStyle_Attribute_GUID: TGuid = '{C1097C90-D5C4-4237-9781-3BEC8BA54E48}';
  {$EXTERNALSYM Text_BulletStyle_Attribute_GUID}
  Text_CapStyle_Attribute_GUID: TGuid = '{FB059C50-92CC-49A5-BA8F-0AA872BBA2F3}';
  {$EXTERNALSYM Text_CapStyle_Attribute_GUID}
  Text_Culture_Attribute_GUID: TGuid = '{C2025AF9-A42D-4CED-A1FB-C6746315222E}';
  {$EXTERNALSYM Text_Culture_Attribute_GUID}
  Text_FontName_Attribute_GUID: TGuid = '{64E63BA8-F2E5-476E-A477-1734FEAAF726}';
  {$EXTERNALSYM Text_FontName_Attribute_GUID}
  Text_FontSize_Attribute_GUID: TGuid = '{DC5EEEFF-0506-4673-93F2-377E4A8E01F1}';
  {$EXTERNALSYM Text_FontSize_Attribute_GUID}
  Text_FontWeight_Attribute_GUID: TGuid = '{6FC02359-B316-4F5F-B401-F1CE55741853}';
  {$EXTERNALSYM Text_FontWeight_Attribute_GUID}
  Text_ForegroundColor_Attribute_GUID: TGuid = '{72D1C95D-5E60-471A-96B1-6C1B3B77A436}';
  {$EXTERNALSYM Text_ForegroundColor_Attribute_GUID}
  Text_HorizontalTextAlignment_Attribute_GUID: TGuid = '{04EA6161-FBA3-477A-952A-BB326D026A5B}';
  {$EXTERNALSYM Text_HorizontalTextAlignment_Attribute_GUID}
  Text_IndentationFirstLine_Attribute_GUID: TGuid = '{206F9AD5-C1D3-424A-8182-6DA9A7F3D632}';
  {$EXTERNALSYM Text_IndentationFirstLine_Attribute_GUID}
  Text_IndentationLeading_Attribute_GUID: TGuid = '{5CF66BAC-2D45-4A4B-B6C9-F7221D2815B0}';
  {$EXTERNALSYM Text_IndentationLeading_Attribute_GUID}
  Text_IndentationTrailing_Attribute_GUID: TGuid = '{97FF6C0F-1CE4-408A-B67B-94D83EB69BF2}';
  {$EXTERNALSYM Text_IndentationTrailing_Attribute_GUID}
  Text_IsHidden_Attribute_GUID: TGuid = '{360182FB-BDD7-47F6-AB69-19E33F8A3344}';
  {$EXTERNALSYM Text_IsHidden_Attribute_GUID}
  Text_IsItalic_Attribute_GUID: TGuid = '{FCE12A56-1336-4A34-9663-1BAB47239320}';
  {$EXTERNALSYM Text_IsItalic_Attribute_GUID}
  Text_IsReadOnly_Attribute_GUID: TGuid = '{A738156B-CA3E-495E-9514-833C440FEB11}';
  {$EXTERNALSYM Text_IsReadOnly_Attribute_GUID}
  Text_IsSubscript_Attribute_GUID: TGuid = '{F0EAD858-8F53-413C-873F-1A7D7F5E0DE4}';
  {$EXTERNALSYM Text_IsSubscript_Attribute_GUID}
  Text_IsSuperscript_Attribute_GUID: TGuid = '{DA706EE4-B3AA-4645-A41F-CD25157DEA76}';
  {$EXTERNALSYM Text_IsSuperscript_Attribute_GUID}
  Text_MarginBottom_Attribute_GUID: TGuid = '{7EE593C4-72B4-4CAC-9271-3ED24B0E4D42}';
  {$EXTERNALSYM Text_MarginBottom_Attribute_GUID}
  Text_MarginLeading_Attribute_GUID: TGuid = '{9E9242D0-5ED0-4900-8E8A-EECC03835AFC}';
  {$EXTERNALSYM Text_MarginLeading_Attribute_GUID}
  Text_MarginTop_Attribute_GUID: TGuid = '{683D936F-C9B9-4A9A-B3D9-D20D33311E2A}';
  {$EXTERNALSYM Text_MarginTop_Attribute_GUID}
  Text_MarginTrailing_Attribute_GUID: TGuid = '{AF522F98-999D-40AF-A5B2-0169D0342002}';
  {$EXTERNALSYM Text_MarginTrailing_Attribute_GUID}
  Text_OutlineStyles_Attribute_GUID: TGuid = '{5B675B27-DB89-46FE-970C-614D523BB97D}';
  {$EXTERNALSYM Text_OutlineStyles_Attribute_GUID}
  Text_OverlineColor_Attribute_GUID: TGuid = '{83AB383A-FD43-40DA-AB3E-ECF8165CBB6D}';
  {$EXTERNALSYM Text_OverlineColor_Attribute_GUID}
  Text_OverlineStyle_Attribute_GUID: TGuid = '{0A234D66-617E-427F-871D-E1FF1E0C213F}';
  {$EXTERNALSYM Text_OverlineStyle_Attribute_GUID}
  Text_StrikethroughColor_Attribute_GUID: TGuid = '{BFE15A18-8C41-4C5A-9A0B-04AF0E07F487}';
  {$EXTERNALSYM Text_StrikethroughColor_Attribute_GUID}
  Text_StrikethroughStyle_Attribute_GUID: TGuid = '{72913EF1-DA00-4F01-899C-AC5A8577A307}';
  {$EXTERNALSYM Text_StrikethroughStyle_Attribute_GUID}
  Text_Tabs_Attribute_GUID: TGuid = '{2E68D00B-92FE-42D8-899A-A784AA4454A1}';
  {$EXTERNALSYM Text_Tabs_Attribute_GUID}
  Text_TextFlowDirections_Attribute_GUID: TGuid = '{8BDF8739-F420-423E-AF77-20A5D973A907}';
  {$EXTERNALSYM Text_TextFlowDirections_Attribute_GUID}
  Text_UnderlineColor_Attribute_GUID: TGuid = '{BFA12C73-FDE2-4473-BF64-1036D6AA0F45}';
  {$EXTERNALSYM Text_UnderlineColor_Attribute_GUID}
  Text_UnderlineStyle_Attribute_GUID: TGuid = '{5F3B21C0-EDE4-44BD-9C36-3853038CBFEB}';
  {$EXTERNALSYM Text_UnderlineStyle_Attribute_GUID}
  Text_AnnotationTypes_Attribute_GUID: TGuid = '{AD2EB431-EE4E-4BE1-A7BA-5559155A73EF}';
  {$EXTERNALSYM Text_AnnotationTypes_Attribute_GUID}
  Text_AnnotationObjects_Attribute_GUID: TGuid = '{FF41CF68-E7AB-40B9-8C72-72A8ED94017D}';
  {$EXTERNALSYM Text_AnnotationObjects_Attribute_GUID}
  Text_StyleName_Attribute_GUID: TGuid = '{22C9E091-4D66-45D8-A828-737BAB4C98A7}';
  {$EXTERNALSYM Text_StyleName_Attribute_GUID}
  Text_StyleId_Attribute_GUID: TGuid = '{14C300DE-C32B-449B-AB7C-B0E0789AEA5D}';
  {$EXTERNALSYM Text_StyleId_Attribute_GUID}
  Text_Link_Attribute_GUID: TGuid = '{B38EF51D-9E8D-4E46-9144-56EBE177329B}';
  {$EXTERNALSYM Text_Link_Attribute_GUID}
  Text_IsActive_Attribute_GUID: TGuid = '{F5A4E533-E1B8-436B-935D-B57AA3F558C4}';
  {$EXTERNALSYM Text_IsActive_Attribute_GUID}
  Text_SelectionActiveEnd_Attribute_GUID: TGuid = '{1F668CC3-9BBF-416B-B0A2-F89F86F6612C}';
  {$EXTERNALSYM Text_SelectionActiveEnd_Attribute_GUID}
  Text_CaretPosition_Attribute_GUID: TGuid = '{B227B131-9889-4752-A91B-733EFDC5C5A0}';
  {$EXTERNALSYM Text_CaretPosition_Attribute_GUID}
  Text_CaretBidiMode_Attribute_GUID: TGuid = '{929EE7A6-51D3-4715-96DC-B694FA24A168}';
  {$EXTERNALSYM Text_CaretBidiMode_Attribute_GUID}
  Text_BeforeParagraphSpacing_Attribute_GUID: TGuid = '{BE7B0AB1-C822-4A24-85E9-C8F2650FC79C}';
  {$EXTERNALSYM Text_BeforeParagraphSpacing_Attribute_GUID}
  Text_AfterParagraphSpacing_Attribute_GUID: TGuid = '{588CBB38-E62F-497C-B5D1-CCDF0EE823D8}';
  {$EXTERNALSYM Text_AfterParagraphSpacing_Attribute_GUID}
  Text_LineSpacing_Attribute_GUID: TGuid = '{63FF70AE-D943-4B47-8AB7-A7A033D3214B}';
  {$EXTERNALSYM Text_LineSpacing_Attribute_GUID}
  Text_BeforeSpacing_Attribute_GUID: TGuid = '{BE7B0AB1-C822-4A24-85E9-C8F2650FC79C}';
  {$EXTERNALSYM Text_BeforeSpacing_Attribute_GUID}
  Text_AfterSpacing_Attribute_GUID: TGuid = '{588CBB38-E62F-497C-B5D1-CCDF0EE823D8}';
  {$EXTERNALSYM Text_AfterSpacing_Attribute_GUID}
  Text_SayAsInterpretAs_Attribute_GUID: TGuid = '{B38AD6AC-EEE1-4B6E-88CC-014CEFA93FCB}';
  {$EXTERNALSYM Text_SayAsInterpretAs_Attribute_GUID}
  TextEdit_TextChanged_Event_GUID: TGuid = '{120B0308-EC22-4EB8-9C98-9867CDA1B165}';
  {$EXTERNALSYM TextEdit_TextChanged_Event_GUID}
  TextEdit_ConversionTargetChanged_Event_GUID: TGuid = '{3388C183-ED4F-4C8B-9BAA-364D51D8847F}';
  {$EXTERNALSYM TextEdit_ConversionTargetChanged_Event_GUID}
  Changes_Event_GUID: TGuid = '{7DF26714-614F-4E05-9488-716C5BA19436}';
  {$EXTERNALSYM Changes_Event_GUID}
  Annotation_Custom_GUID: TGuid = '{9EC82750-3931-4952-85BC-1DBFF78A43E3}';
  {$EXTERNALSYM Annotation_Custom_GUID}
  Annotation_SpellingError_GUID: TGuid = '{AE85567E-9ECE-423F-81B7-96C43D53E50E}';
  {$EXTERNALSYM Annotation_SpellingError_GUID}
  Annotation_GrammarError_GUID: TGuid = '{757A048D-4518-41C6-854C-DC009B7CFB53}';
  {$EXTERNALSYM Annotation_GrammarError_GUID}
  Annotation_Comment_GUID: TGuid = '{FD2FDA30-26B3-4C06-8BC7-98F1532E46FD}';
  {$EXTERNALSYM Annotation_Comment_GUID}
  Annotation_FormulaError_GUID: TGuid = '{95611982-0CAB-46D5-A2F0-E30D1905F8BF}';
  {$EXTERNALSYM Annotation_FormulaError_GUID}
  Annotation_TrackChanges_GUID: TGuid = '{21E6E888-DC14-4016-AC27-190553C8C470}';
  {$EXTERNALSYM Annotation_TrackChanges_GUID}
  Annotation_Header_GUID: TGuid = '{867B409B-B216-4472-A219-525E310681F8}';
  {$EXTERNALSYM Annotation_Header_GUID}
  Annotation_Footer_GUID: TGuid = '{CCEAB046-1833-47AA-8080-701ED0B0C832}';
  {$EXTERNALSYM Annotation_Footer_GUID}
  Annotation_Highlighted_GUID: TGuid = '{757C884E-8083-4081-8B9C-E87F5072F0E4}';
  {$EXTERNALSYM Annotation_Highlighted_GUID}
  Annotation_Endnote_GUID: TGuid = '{7565725C-2D99-4839-960D-33D3B866ABA5}';
  {$EXTERNALSYM Annotation_Endnote_GUID}
  Annotation_Footnote_GUID: TGuid = '{3DE10E21-4125-42DB-8620-BE8083080624}';
  {$EXTERNALSYM Annotation_Footnote_GUID}
  Annotation_InsertionChange_GUID: TGuid = '{0DBEB3A6-DF15-4164-A3C0-E21A8CE931C4}';
  {$EXTERNALSYM Annotation_InsertionChange_GUID}
  Annotation_DeletionChange_GUID: TGuid = '{BE3D5B05-951D-42E7-901D-ADC8C2CF34D0}';
  {$EXTERNALSYM Annotation_DeletionChange_GUID}
  Annotation_MoveChange_GUID: TGuid = '{9DA587EB-23E5-4490-B385-1A22DDC8B187}';
  {$EXTERNALSYM Annotation_MoveChange_GUID}
  Annotation_FormatChange_GUID: TGuid = '{EB247345-D4F1-41CE-8E52-F79B69635E48}';
  {$EXTERNALSYM Annotation_FormatChange_GUID}
  Annotation_UnsyncedChange_GUID: TGuid = '{1851116A-0E47-4B30-8CB5-D7DAE4FBCD1B}';
  {$EXTERNALSYM Annotation_UnsyncedChange_GUID}
  Annotation_EditingLockedChange_GUID: TGuid = '{C31F3E1C-7423-4DAC-8348-41F099FF6F64}';
  {$EXTERNALSYM Annotation_EditingLockedChange_GUID}
  Annotation_ExternalChange_GUID: TGuid = '{75A05B31-5F11-42FD-887D-DFA010DB2392}';
  {$EXTERNALSYM Annotation_ExternalChange_GUID}
  Annotation_ConflictingChange_GUID: TGuid = '{98AF8802-517C-459F-AF13-016D3FAB877E}';
  {$EXTERNALSYM Annotation_ConflictingChange_GUID}
  Annotation_Author_GUID: TGuid = '{F161D3A7-F81B-4128-B17F-71F690914520}';
  {$EXTERNALSYM Annotation_Author_GUID}
  Annotation_AdvancedProofingIssue_GUID: TGuid = '{DAC7B72C-C0F2-4B84-B90D-5FAFC0F0EF1C}';
  {$EXTERNALSYM Annotation_AdvancedProofingIssue_GUID}
  Annotation_DataValidationError_GUID: TGuid = '{C8649FA8-9775-437E-AD46-E709D93C2343}';
  {$EXTERNALSYM Annotation_DataValidationError_GUID}
  Annotation_CircularReferenceError_GUID: TGuid = '{25BD9CF4-1745-4659-BA67-727F0318C616}';
  {$EXTERNALSYM Annotation_CircularReferenceError_GUID}
  Annotation_Mathematics_GUID: TGuid = '{EAAB634B-26D0-40C1-8073-57CA1C633C9B}';
  {$EXTERNALSYM Annotation_Mathematics_GUID}
  Annotation_Sensitive_GUID: TGuid = '{37F4C04F-0F12-4464-929C-828FD15292E3}';
  {$EXTERNALSYM Annotation_Sensitive_GUID}
  Changes_Summary_GUID: TGuid = '{313D65A6-E60F-4D62-9861-55AFD728D207}';
  {$EXTERNALSYM Changes_Summary_GUID}
  StyleId_Custom_GUID: TGuid = '{EF2EDD3E-A999-4B7C-A378-09BBD52A3516}';
  {$EXTERNALSYM StyleId_Custom_GUID}
  StyleId_Heading1_GUID: TGuid = '{7F7E8F69-6866-4621-930C-9A5D0CA5961C}';
  {$EXTERNALSYM StyleId_Heading1_GUID}
  StyleId_Heading2_GUID: TGuid = '{BAA9B241-5C69-469D-85AD-474737B52B14}';
  {$EXTERNALSYM StyleId_Heading2_GUID}
  StyleId_Heading3_GUID: TGuid = '{BF8BE9D2-D8B8-4EC5-8C52-9CFB0D035970}';
  {$EXTERNALSYM StyleId_Heading3_GUID}
  StyleId_Heading4_GUID: TGuid = '{8436FFC0-9578-45FC-83A4-FF40053315DD}';
  {$EXTERNALSYM StyleId_Heading4_GUID}
  StyleId_Heading5_GUID: TGuid = '{909F424D-0DBF-406E-97BB-4E773D9798F7}';
  {$EXTERNALSYM StyleId_Heading5_GUID}
  StyleId_Heading6_GUID: TGuid = '{89D23459-5D5B-4824-A420-11D3ED82E40F}';
  {$EXTERNALSYM StyleId_Heading6_GUID}
  StyleId_Heading7_GUID: TGuid = '{A3790473-E9AE-422D-B8E3-3B675C6181A4}';
  {$EXTERNALSYM StyleId_Heading7_GUID}
  StyleId_Heading8_GUID: TGuid = '{2BC14145-A40C-4881-84AE-F2235685380C}';
  {$EXTERNALSYM StyleId_Heading8_GUID}
  StyleId_Heading9_GUID: TGuid = '{C70D9133-BB2A-43D3-8AC6-33657884B0F0}';
  {$EXTERNALSYM StyleId_Heading9_GUID}
  StyleId_Title_GUID: TGuid = '{15D8201A-FFCF-481F-B0A1-30B63BE98F07}';
  {$EXTERNALSYM StyleId_Title_GUID}
  StyleId_Subtitle_GUID: TGuid = '{B5D9FC17-5D6F-4420-B439-7CB19AD434E2}';
  {$EXTERNALSYM StyleId_Subtitle_GUID}
  StyleId_Normal_GUID: TGuid = '{CD14D429-E45E-4475-A1C5-7F9E6BE96EBA}';
  {$EXTERNALSYM StyleId_Normal_GUID}
  StyleId_Emphasis_GUID: TGuid = '{CA6E7DBE-355E-4820-95A0-925F041D3470}';
  {$EXTERNALSYM StyleId_Emphasis_GUID}
  StyleId_Quote_GUID: TGuid = '{5D1C21EA-8195-4F6C-87EA-5DABECE64C1D}';
  {$EXTERNALSYM StyleId_Quote_GUID}
  StyleId_BulletedList_GUID: TGuid = '{5963ED64-6426-4632-8CAF-A32AD402D91A}';
  {$EXTERNALSYM StyleId_BulletedList_GUID}
  StyleId_NumberedList_GUID: TGuid = '{1E96DBD5-64C3-43D0-B1EE-B53B06E3EDDF}';
  {$EXTERNALSYM StyleId_NumberedList_GUID}
  Notification_Event_GUID: TGuid = '{72C5A2F7-9788-480F-B8EB-4DEE00F6186F}';
  {$EXTERNALSYM Notification_Event_GUID}
  SID_IsUIAutomationObject: TGuid = '{B96FDB85-7204-4724-842B-C7059DEDB9D0}';
  {$EXTERNALSYM SID_IsUIAutomationObject}
  SID_ControlElementProvider: TGuid = '{F4791D68-E254-4BA3-9A53-26A5C5497946}';
  {$EXTERNALSYM SID_ControlElementProvider}
  IsSelectionPattern2Available_Property_GUID: TGuid = '{490806FB-6E89-4A47-8319-D266E511F021}';
  {$EXTERNALSYM IsSelectionPattern2Available_Property_GUID}
  Selection2_FirstSelectedItem_Property_GUID: TGuid = '{CC24EA67-369C-4E55-9FF7-38DA69540C29}';
  {$EXTERNALSYM Selection2_FirstSelectedItem_Property_GUID}
  Selection2_LastSelectedItem_Property_GUID: TGuid = '{CF7BDA90-2D83-49F8-860C-9CE394CF89B4}';
  {$EXTERNALSYM Selection2_LastSelectedItem_Property_GUID}
  Selection2_CurrentSelectedItem_Property_GUID: TGuid = '{34257C26-83B5-41A6-939C-AE841C136236}';
  {$EXTERNALSYM Selection2_CurrentSelectedItem_Property_GUID}
  Selection2_ItemCount_Property_GUID: TGuid = '{BB49EB9F-456D-4048-B591-9C2026B84636}';
  {$EXTERNALSYM Selection2_ItemCount_Property_GUID}
  Selection_Pattern2_GUID: TGuid = '{FBA25CAB-AB98-49F7-A7DC-FE539DC15BE7}';
  {$EXTERNALSYM Selection_Pattern2_GUID}
  HeadingLevel_Property_GUID: TGuid = '{29084272-AAAF-4A30-8796-3C12F62B6BBB}';
  {$EXTERNALSYM HeadingLevel_Property_GUID}
  IsDialog_Property_GUID: TGuid = '{9D0DFB9B-8436-4501-BBBB-E534A4FB3B3F}';
  {$EXTERNALSYM IsDialog_Property_GUID}
  UIA_IAFP_DEFAULT = $0 {0};
  {$EXTERNALSYM UIA_IAFP_DEFAULT}
  UIA_IAFP_UNWRAP_BRIDGE = $1 {1};
  {$EXTERNALSYM UIA_IAFP_UNWRAP_BRIDGE}
  UIA_PFIA_DEFAULT = $0 {0};
  {$EXTERNALSYM UIA_PFIA_DEFAULT}
  UIA_PFIA_UNWRAP_BRIDGE = $1 {1};
  {$EXTERNALSYM UIA_PFIA_UNWRAP_BRIDGE}
  UIA_ScrollPatternNoScroll = -1;
  {$EXTERNALSYM UIA_ScrollPatternNoScroll}

// Windows  UI Automation API functions

///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiageterrordescription</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaGetErrorDescription(var pDescription: PChar): BOOL; stdcall;
{$EXTERNALSYM UiaGetErrorDescription}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiahuianodefromvariant</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaHUiaNodeFromVariant(var pvar: OleVariant; var phnode: HUIANODE): HRESULT; stdcall;
{$EXTERNALSYM UiaHUiaNodeFromVariant}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiahpatternobjectfromvariant</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaHPatternObjectFromVariant(var pvar: OleVariant; var phobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM UiaHPatternObjectFromVariant}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiahtextrangefromvariant</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaHTextRangeFromVariant(var pvar: OleVariant; var phtextrange: HUIATEXTRANGE): HRESULT; stdcall;
{$EXTERNALSYM UiaHTextRangeFromVariant}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uianoderelease</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaNodeRelease(hnode: HUIANODE): BOOL; stdcall;
{$EXTERNALSYM UiaNodeRelease}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiagetpropertyvalue</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaGetPropertyValue(hnode: HUIANODE; propertyId: Integer; var pValue: OleVariant): HRESULT; stdcall;
{$EXTERNALSYM UiaGetPropertyValue}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiagetpatternprovider</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaGetPatternProvider(hnode: HUIANODE; patternId: Integer; var phobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM UiaGetPatternProvider}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiagetruntimeid</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaGetRuntimeId(hnode: HUIANODE; var pruntimeId: SAFEARRAY): HRESULT; stdcall;
{$EXTERNALSYM UiaGetRuntimeId}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiasetfocus</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaSetFocus(hnode: HUIANODE): HRESULT; stdcall;
{$EXTERNALSYM UiaSetFocus}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uianavigate</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaNavigate(hnode: HUIANODE; direction: NavigateDirection; var pCondition: UiaCondition; var pRequest: UiaCacheRequest; var ppRequestedData: SAFEARRAY; var ppTreeStructure: PChar): HRESULT; stdcall;
{$EXTERNALSYM UiaNavigate}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiagetupdatedcache</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaGetUpdatedCache(hnode: HUIANODE; var pRequest: UiaCacheRequest; normalizeState: NormalizeState; var pNormalizeCondition: UiaCondition; var ppRequestedData: SAFEARRAY; var ppTreeStructure: PChar): HRESULT; stdcall;
{$EXTERNALSYM UiaGetUpdatedCache}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiafind</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaFind(hnode: HUIANODE; var pParams: UiaFindParams; var pRequest: UiaCacheRequest; var ppRequestedData: SAFEARRAY; var ppOffsets: SAFEARRAY; var ppTreeStructures: SAFEARRAY): HRESULT; stdcall;
{$EXTERNALSYM UiaFind}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uianodefrompoint</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaNodeFromPoint(x: Double; y: Double; var pRequest: UiaCacheRequest; var ppRequestedData: SAFEARRAY; var ppTreeStructure: PChar): HRESULT; stdcall;
{$EXTERNALSYM UiaNodeFromPoint}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uianodefromfocus</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaNodeFromFocus(var pRequest: UiaCacheRequest; var ppRequestedData: SAFEARRAY; var ppTreeStructure: PChar): HRESULT; stdcall;
{$EXTERNALSYM UiaNodeFromFocus}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uianodefromhandle</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaNodeFromHandle(hwnd: HWND; var phnode: HUIANODE): HRESULT; stdcall;
{$EXTERNALSYM UiaNodeFromHandle}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uianodefromprovider</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaNodeFromProvider(pProvider: IRawElementProviderSimple; var phnode: HUIANODE): HRESULT; stdcall;
{$EXTERNALSYM UiaNodeFromProvider}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiagetrootnode</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaGetRootNode(var phnode: HUIANODE): HRESULT; stdcall;
{$EXTERNALSYM UiaGetRootNode}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaregisterprovidercallback</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
procedure UiaRegisterProviderCallback(var pCallback: UiaProviderCallback); stdcall;
{$EXTERNALSYM UiaRegisterProviderCallback}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uialookupid</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaLookupId(&type: AutomationIdentifierType; pGuid: PGuid): Integer; stdcall;
{$EXTERNALSYM UiaLookupId}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiagetreservednotsupportedvalue</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaGetReservedNotSupportedValue(out punkNotSupportedValue: IUnknown): HRESULT; stdcall;
{$EXTERNALSYM UiaGetReservedNotSupportedValue}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiagetreservedmixedattributevalue</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaGetReservedMixedAttributeValue(out punkMixedAttributeValue: IUnknown): HRESULT; stdcall;
{$EXTERNALSYM UiaGetReservedMixedAttributeValue}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaclientsarelistening</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaClientsAreListening: BOOL; stdcall;
{$EXTERNALSYM UiaClientsAreListening}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaraiseautomationpropertychangedevent</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaRaiseAutomationPropertyChangedEvent(pProvider: IRawElementProviderSimple; id: UIA_PROPERTY_ID; oldValue: OleVariant; newValue: OleVariant): HRESULT; stdcall;
{$EXTERNALSYM UiaRaiseAutomationPropertyChangedEvent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaraiseautomationevent</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaRaiseAutomationEvent(pProvider: IRawElementProviderSimple; id: UIA_EVENT_ID): HRESULT; stdcall;
{$EXTERNALSYM UiaRaiseAutomationEvent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaraisestructurechangedevent</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaRaiseStructureChangedEvent(pProvider: IRawElementProviderSimple; structureChangeType: StructureChangeType; var pRuntimeId: Integer; cRuntimeIdLen: Integer): HRESULT; stdcall;
{$EXTERNALSYM UiaRaiseStructureChangedEvent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaraiseasynccontentloadedevent</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaRaiseAsyncContentLoadedEvent(pProvider: IRawElementProviderSimple; asyncContentLoadedState: AsyncContentLoadedState; percentComplete: Double): HRESULT; stdcall;
{$EXTERNALSYM UiaRaiseAsyncContentLoadedEvent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaraisetextedittextchangedevent</summary>
///<remarks>
///<para>Supported since: <i>windows8.1</i></para>
///</remarks>
function UiaRaiseTextEditTextChangedEvent(pProvider: IRawElementProviderSimple; textEditChangeType: TextEditChangeType; var pChangedData: SAFEARRAY): HRESULT; stdcall;
{$EXTERNALSYM UiaRaiseTextEditTextChangedEvent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaraisechangesevent</summary>
///<remarks>
///<para>Supported since: <i>windows10.0.10240</i></para>
///</remarks>
function UiaRaiseChangesEvent(pProvider: IRawElementProviderSimple; eventIdCount: Integer; var pUiaChanges: UiaChangeInfo): HRESULT; stdcall;
{$EXTERNALSYM UiaRaiseChangesEvent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaraisenotificationevent</summary>
///<remarks>
///<para>Supported since: <i>windows10.0.16299</i></para>
///</remarks>
function UiaRaiseNotificationEvent(provider: IRawElementProviderSimple; notificationKind: NotificationKind; notificationProcessing: NotificationProcessing; displayString: PChar; activityId: PChar): HRESULT; stdcall;
{$EXTERNALSYM UiaRaiseNotificationEvent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaraiseactivetextpositionchangedevent</summary>
///<remarks>
///<para>Supported since: <i>windows8.1</i></para>
///</remarks>
function UiaRaiseActiveTextPositionChangedEvent(provider: IRawElementProviderSimple; textRange: ITextRangeProvider): HRESULT; stdcall;
{$EXTERNALSYM UiaRaiseActiveTextPositionChangedEvent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaaddevent</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaAddEvent(hnode: HUIANODE; eventId: Integer; var pCallback: UiaEventCallback; scope: TreeScope; var pProperties: Integer; cProperties: Integer; var pRequest: UiaCacheRequest; var phEvent: HUIAEVENT): HRESULT; stdcall;
{$EXTERNALSYM UiaAddEvent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaremoveevent</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaRemoveEvent(hEvent: HUIAEVENT): HRESULT; stdcall;
{$EXTERNALSYM UiaRemoveEvent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaeventaddwindow</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaEventAddWindow(hEvent: HUIAEVENT; hwnd: HWND): HRESULT; stdcall;
{$EXTERNALSYM UiaEventAddWindow}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaeventremovewindow</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaEventRemoveWindow(hEvent: HUIAEVENT; hwnd: HWND): HRESULT; stdcall;
{$EXTERNALSYM UiaEventRemoveWindow}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-dockpattern_setdockposition</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function DockPattern_SetDockPosition(hobj: HUIAPATTERNOBJECT; dockPosition: DockPosition): HRESULT; stdcall;
{$EXTERNALSYM DockPattern_SetDockPosition}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-expandcollapsepattern_collapse</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function ExpandCollapsePattern_Collapse(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM ExpandCollapsePattern_Collapse}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-expandcollapsepattern_expand</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function ExpandCollapsePattern_Expand(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM ExpandCollapsePattern_Expand}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-gridpattern_getitem</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function GridPattern_GetItem(hobj: HUIAPATTERNOBJECT; row: Integer; column: Integer; var pResult: HUIANODE): HRESULT; stdcall;
{$EXTERNALSYM GridPattern_GetItem}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-invokepattern_invoke</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function InvokePattern_Invoke(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM InvokePattern_Invoke}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-multipleviewpattern_getviewname</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function MultipleViewPattern_GetViewName(hobj: HUIAPATTERNOBJECT; viewId: Integer; var ppStr: PChar): HRESULT; stdcall;
{$EXTERNALSYM MultipleViewPattern_GetViewName}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-multipleviewpattern_setcurrentview</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function MultipleViewPattern_SetCurrentView(hobj: HUIAPATTERNOBJECT; viewId: Integer): HRESULT; stdcall;
{$EXTERNALSYM MultipleViewPattern_SetCurrentView}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-rangevaluepattern_setvalue</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function RangeValuePattern_SetValue(hobj: HUIAPATTERNOBJECT; val: Double): HRESULT; stdcall;
{$EXTERNALSYM RangeValuePattern_SetValue}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-scrollitempattern_scrollintoview</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function ScrollItemPattern_ScrollIntoView(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM ScrollItemPattern_ScrollIntoView}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-scrollpattern_scroll</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function ScrollPattern_Scroll(hobj: HUIAPATTERNOBJECT; horizontalAmount: ScrollAmount; verticalAmount: ScrollAmount): HRESULT; stdcall;
{$EXTERNALSYM ScrollPattern_Scroll}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-scrollpattern_setscrollpercent</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function ScrollPattern_SetScrollPercent(hobj: HUIAPATTERNOBJECT; horizontalPercent: Double; verticalPercent: Double): HRESULT; stdcall;
{$EXTERNALSYM ScrollPattern_SetScrollPercent}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-selectionitempattern_addtoselection</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function SelectionItemPattern_AddToSelection(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM SelectionItemPattern_AddToSelection}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-selectionitempattern_removefromselection</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function SelectionItemPattern_RemoveFromSelection(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM SelectionItemPattern_RemoveFromSelection}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-selectionitempattern_select</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function SelectionItemPattern_Select(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM SelectionItemPattern_Select}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-togglepattern_toggle</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TogglePattern_Toggle(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM TogglePattern_Toggle}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-transformpattern_move</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TransformPattern_Move(hobj: HUIAPATTERNOBJECT; x: Double; y: Double): HRESULT; stdcall;
{$EXTERNALSYM TransformPattern_Move}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-transformpattern_resize</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TransformPattern_Resize(hobj: HUIAPATTERNOBJECT; width: Double; height: Double): HRESULT; stdcall;
{$EXTERNALSYM TransformPattern_Resize}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-transformpattern_rotate</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TransformPattern_Rotate(hobj: HUIAPATTERNOBJECT; degrees: Double): HRESULT; stdcall;
{$EXTERNALSYM TransformPattern_Rotate}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-valuepattern_setvalue</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function ValuePattern_SetValue(hobj: HUIAPATTERNOBJECT; pVal: PChar): HRESULT; stdcall;
{$EXTERNALSYM ValuePattern_SetValue}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-windowpattern_close</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function WindowPattern_Close(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM WindowPattern_Close}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-windowpattern_setwindowvisualstate</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function WindowPattern_SetWindowVisualState(hobj: HUIAPATTERNOBJECT; state: WindowVisualState): HRESULT; stdcall;
{$EXTERNALSYM WindowPattern_SetWindowVisualState}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-windowpattern_waitforinputidle</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function WindowPattern_WaitForInputIdle(hobj: HUIAPATTERNOBJECT; milliseconds: Integer; var pResult: BOOL): HRESULT; stdcall;
{$EXTERNALSYM WindowPattern_WaitForInputIdle}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textpattern_getselection</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextPattern_GetSelection(hobj: HUIAPATTERNOBJECT; var pRetVal: SAFEARRAY): HRESULT; stdcall;
{$EXTERNALSYM TextPattern_GetSelection}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textpattern_getvisibleranges</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextPattern_GetVisibleRanges(hobj: HUIAPATTERNOBJECT; var pRetVal: SAFEARRAY): HRESULT; stdcall;
{$EXTERNALSYM TextPattern_GetVisibleRanges}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textpattern_rangefromchild</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextPattern_RangeFromChild(hobj: HUIAPATTERNOBJECT; hnodeChild: HUIANODE; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall;
{$EXTERNALSYM TextPattern_RangeFromChild}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textpattern_rangefrompoint</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextPattern_RangeFromPoint(hobj: HUIAPATTERNOBJECT; point: UiaPoint; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall;
{$EXTERNALSYM TextPattern_RangeFromPoint}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textpattern_get_documentrange</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextPattern_get_DocumentRange(hobj: HUIAPATTERNOBJECT; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall;
{$EXTERNALSYM TextPattern_get_DocumentRange}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textpattern_get_supportedtextselection</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextPattern_get_SupportedTextSelection(hobj: HUIAPATTERNOBJECT; var pRetVal: SupportedTextSelection): HRESULT; stdcall;
{$EXTERNALSYM TextPattern_get_SupportedTextSelection}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_clone</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_Clone(hobj: HUIATEXTRANGE; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall;
{$EXTERNALSYM TextRange_Clone}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_compare</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_Compare(hobj: HUIATEXTRANGE; range: HUIATEXTRANGE; var pRetVal: BOOL): HRESULT; stdcall;
{$EXTERNALSYM TextRange_Compare}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_compareendpoints</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_CompareEndpoints(hobj: HUIATEXTRANGE; endpoint: TextPatternRangeEndpoint; targetRange: HUIATEXTRANGE; targetEndpoint: TextPatternRangeEndpoint; var pRetVal: Integer): HRESULT; stdcall;
{$EXTERNALSYM TextRange_CompareEndpoints}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_expandtoenclosingunit</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_ExpandToEnclosingUnit(hobj: HUIATEXTRANGE; &unit: TextUnit): HRESULT; stdcall;
{$EXTERNALSYM TextRange_ExpandToEnclosingUnit}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_getattributevalue</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_GetAttributeValue(hobj: HUIATEXTRANGE; attributeId: Integer; var pRetVal: OleVariant): HRESULT; stdcall;
{$EXTERNALSYM TextRange_GetAttributeValue}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_findattribute</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_FindAttribute(hobj: HUIATEXTRANGE; attributeId: Integer; val: OleVariant; backward: BOOL; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall;
{$EXTERNALSYM TextRange_FindAttribute}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_findtext</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_FindText(hobj: HUIATEXTRANGE; text: PChar; backward: BOOL; ignoreCase: BOOL; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall;
{$EXTERNALSYM TextRange_FindText}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_getboundingrectangles</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_GetBoundingRectangles(hobj: HUIATEXTRANGE; var pRetVal: SAFEARRAY): HRESULT; stdcall;
{$EXTERNALSYM TextRange_GetBoundingRectangles}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_getenclosingelement</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_GetEnclosingElement(hobj: HUIATEXTRANGE; var pRetVal: HUIANODE): HRESULT; stdcall;
{$EXTERNALSYM TextRange_GetEnclosingElement}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_gettext</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_GetText(hobj: HUIATEXTRANGE; maxLength: Integer; var pRetVal: PChar): HRESULT; stdcall;
{$EXTERNALSYM TextRange_GetText}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_move</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_Move(hobj: HUIATEXTRANGE; &unit: TextUnit; count: Integer; var pRetVal: Integer): HRESULT; stdcall;
{$EXTERNALSYM TextRange_Move}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_moveendpointbyunit</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_MoveEndpointByUnit(hobj: HUIATEXTRANGE; endpoint: TextPatternRangeEndpoint; &unit: TextUnit; count: Integer; var pRetVal: Integer): HRESULT; stdcall;
{$EXTERNALSYM TextRange_MoveEndpointByUnit}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_moveendpointbyrange</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_MoveEndpointByRange(hobj: HUIATEXTRANGE; endpoint: TextPatternRangeEndpoint; targetRange: HUIATEXTRANGE; targetEndpoint: TextPatternRangeEndpoint): HRESULT; stdcall;
{$EXTERNALSYM TextRange_MoveEndpointByRange}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_select</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_Select(hobj: HUIATEXTRANGE): HRESULT; stdcall;
{$EXTERNALSYM TextRange_Select}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_addtoselection</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_AddToSelection(hobj: HUIATEXTRANGE): HRESULT; stdcall;
{$EXTERNALSYM TextRange_AddToSelection}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_removefromselection</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_RemoveFromSelection(hobj: HUIATEXTRANGE): HRESULT; stdcall;
{$EXTERNALSYM TextRange_RemoveFromSelection}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_scrollintoview</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_ScrollIntoView(hobj: HUIATEXTRANGE; alignToTop: BOOL): HRESULT; stdcall;
{$EXTERNALSYM TextRange_ScrollIntoView}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-textrange_getchildren</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function TextRange_GetChildren(hobj: HUIATEXTRANGE; var pRetVal: SAFEARRAY): HRESULT; stdcall;
{$EXTERNALSYM TextRange_GetChildren}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-itemcontainerpattern_finditembyproperty</summary>
///<remarks>
///<para>Supported since: <i>windows6.1</i></para>
///</remarks>
function ItemContainerPattern_FindItemByProperty(hobj: HUIAPATTERNOBJECT; hnodeStartAfter: HUIANODE; propertyId: Integer; value: OleVariant; var pFound: HUIANODE): HRESULT; stdcall;
{$EXTERNALSYM ItemContainerPattern_FindItemByProperty}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-legacyiaccessiblepattern_select</summary>
///<remarks>
///<para>Supported since: <i>windows6.1</i></para>
///</remarks>
function LegacyIAccessiblePattern_Select(hobj: HUIAPATTERNOBJECT; flagsSelect: Integer): HRESULT; stdcall;
{$EXTERNALSYM LegacyIAccessiblePattern_Select}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-legacyiaccessiblepattern_dodefaultaction</summary>
///<remarks>
///<para>Supported since: <i>windows6.1</i></para>
///</remarks>
function LegacyIAccessiblePattern_DoDefaultAction(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM LegacyIAccessiblePattern_DoDefaultAction}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-legacyiaccessiblepattern_setvalue</summary>
///<remarks>
///<para>Supported since: <i>windows6.1</i></para>
///</remarks>
function LegacyIAccessiblePattern_SetValue(hobj: HUIAPATTERNOBJECT; szValue: PChar): HRESULT; stdcall;
{$EXTERNALSYM LegacyIAccessiblePattern_SetValue}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-legacyiaccessiblepattern_getiaccessible</summary>
///<remarks>
///<para>Supported since: <i>windows6.1</i></para>
///</remarks>
function LegacyIAccessiblePattern_GetIAccessible(hobj: HUIAPATTERNOBJECT; out pAccessible: IAccessible): HRESULT; stdcall;
{$EXTERNALSYM LegacyIAccessiblePattern_GetIAccessible}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-synchronizedinputpattern_startlistening</summary>
///<remarks>
///<para>Supported since: <i>windows6.1</i></para>
///</remarks>
function SynchronizedInputPattern_StartListening(hobj: HUIAPATTERNOBJECT; inputType: SynchronizedInputType): HRESULT; stdcall;
{$EXTERNALSYM SynchronizedInputPattern_StartListening}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-synchronizedinputpattern_cancel</summary>
///<remarks>
///<para>Supported since: <i>windows6.1</i></para>
///</remarks>
function SynchronizedInputPattern_Cancel(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM SynchronizedInputPattern_Cancel}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-virtualizeditempattern_realize</summary>
///<remarks>
///<para>Supported since: <i>windows6.1</i></para>
///</remarks>
function VirtualizedItemPattern_Realize(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall;
{$EXTERNALSYM VirtualizedItemPattern_Realize}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiapatternrelease</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaPatternRelease(hobj: HUIAPATTERNOBJECT): BOOL; stdcall;
{$EXTERNALSYM UiaPatternRelease}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiatextrangerelease</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaTextRangeRelease(hobj: HUIATEXTRANGE): BOOL; stdcall;
{$EXTERNALSYM UiaTextRangeRelease}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiareturnrawelementprovider</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaReturnRawElementProvider(hwnd: HWND; wParam: WPARAM; lParam: LPARAM; el: IRawElementProviderSimple): LRESULT; stdcall;
{$EXTERNALSYM UiaReturnRawElementProvider}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiahostproviderfromhwnd</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaHostProviderFromHwnd(hwnd: HWND; out ppProvider: IRawElementProviderSimple): HRESULT; stdcall;
{$EXTERNALSYM UiaHostProviderFromHwnd}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaproviderfornonclient</summary>
///<remarks>
///<para>Supported since: <i>windows8.0</i></para>
///</remarks>
function UiaProviderForNonClient(hwnd: HWND; idObject: Integer; idChild: Integer; out ppProvider: IRawElementProviderSimple): HRESULT; stdcall;
{$EXTERNALSYM UiaProviderForNonClient}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaiaccessiblefromprovider</summary>
///<remarks>
///<para>Supported since: <i>windows8.0</i></para>
///</remarks>
function UiaIAccessibleFromProvider(pProvider: IRawElementProviderSimple; dwFlags: Cardinal; out ppAccessible: IAccessible; out pvarChild: OleVariant): HRESULT; stdcall;
{$EXTERNALSYM UiaIAccessibleFromProvider}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiaproviderfromiaccessible</summary>
///<remarks>
///<para>Supported since: <i>windows8.0</i></para>
///</remarks>
function UiaProviderFromIAccessible(pAccessible: IAccessible; idChild: Integer; dwFlags: Cardinal; out ppProvider: IRawElementProviderSimple): HRESULT; stdcall;
{$EXTERNALSYM UiaProviderFromIAccessible}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiadisconnectallproviders</summary>
///<remarks>
///<para>Supported since: <i>windows8.0</i></para>
///</remarks>
function UiaDisconnectAllProviders: HRESULT; stdcall;
{$EXTERNALSYM UiaDisconnectAllProviders}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiadisconnectprovider</summary>
///<remarks>
///<para>Supported since: <i>windows8.0</i></para>
///</remarks>
function UiaDisconnectProvider(pProvider: IRawElementProviderSimple): HRESULT; stdcall;
{$EXTERNALSYM UiaDisconnectProvider}
///<summary>Documentation: https://docs.microsoft.com/windows/win32/api/uiautomationcoreapi/nf-uiautomationcoreapi-uiahasserversideprovider</summary>
///<remarks>
///<para>Supported since: <i>windows5.1.2600</i></para>
///</remarks>
function UiaHasServerSideProvider(hwnd: HWND): BOOL; stdcall;
{$EXTERNALSYM UiaHasServerSideProvider}

implementation

// Windows UI Automation API functions

function UiaGetErrorDescription(var pDescription: PChar): BOOL; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaGetErrorDescription';
function UiaHUiaNodeFromVariant(var pvar: OleVariant; var phnode: HUIANODE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaHUiaNodeFromVariant';
function UiaHPatternObjectFromVariant(var pvar: OleVariant; var phobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaHPatternObjectFromVariant';
function UiaHTextRangeFromVariant(var pvar: OleVariant; var phtextrange: HUIATEXTRANGE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaHTextRangeFromVariant';
function UiaNodeRelease(hnode: HUIANODE): BOOL; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaNodeRelease';
function UiaGetPropertyValue(hnode: HUIANODE; propertyId: Integer; var pValue: OleVariant): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaGetPropertyValue';
function UiaGetPatternProvider(hnode: HUIANODE; patternId: Integer; var phobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaGetPatternProvider';
function UiaGetRuntimeId(hnode: HUIANODE; var pruntimeId: SAFEARRAY): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaGetRuntimeId';
function UiaSetFocus(hnode: HUIANODE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaSetFocus';
function UiaNavigate(hnode: HUIANODE; direction: NavigateDirection; var pCondition: UiaCondition; var pRequest: UiaCacheRequest; var ppRequestedData: SAFEARRAY; var ppTreeStructure: PChar): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaNavigate';
function UiaGetUpdatedCache(hnode: HUIANODE; var pRequest: UiaCacheRequest; normalizeState: NormalizeState; var pNormalizeCondition: UiaCondition; var ppRequestedData: SAFEARRAY; var ppTreeStructure: PChar): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaGetUpdatedCache';
function UiaFind(hnode: HUIANODE; var pParams: UiaFindParams; var pRequest: UiaCacheRequest; var ppRequestedData: SAFEARRAY; var ppOffsets: SAFEARRAY; var ppTreeStructures: SAFEARRAY): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaFind';
function UiaNodeFromPoint(x: Double; y: Double; var pRequest: UiaCacheRequest; var ppRequestedData: SAFEARRAY; var ppTreeStructure: PChar): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaNodeFromPoint';
function UiaNodeFromFocus(var pRequest: UiaCacheRequest; var ppRequestedData: SAFEARRAY; var ppTreeStructure: PChar): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaNodeFromFocus';
function UiaNodeFromHandle(hwnd: HWND; var phnode: HUIANODE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaNodeFromHandle';
function UiaNodeFromProvider(pProvider: IRawElementProviderSimple; var phnode: HUIANODE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaNodeFromProvider';
function UiaGetRootNode(var phnode: HUIANODE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaGetRootNode';
procedure UiaRegisterProviderCallback(var pCallback: UiaProviderCallback); stdcall; external 'UIAutomationCore.dll' delayed name 'UiaRegisterProviderCallback';
function UiaLookupId(&type: AutomationIdentifierType; pGuid: PGuid): Integer; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaLookupId';
function UiaGetReservedNotSupportedValue(out punkNotSupportedValue: IUnknown): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaGetReservedNotSupportedValue';
function UiaGetReservedMixedAttributeValue(out punkMixedAttributeValue: IUnknown): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaGetReservedMixedAttributeValue';
function UiaClientsAreListening: BOOL; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaClientsAreListening';
function UiaRaiseAutomationPropertyChangedEvent(pProvider: IRawElementProviderSimple; id: UIA_PROPERTY_ID; oldValue: OleVariant; newValue: OleVariant): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaRaiseAutomationPropertyChangedEvent';
function UiaRaiseAutomationEvent(pProvider: IRawElementProviderSimple; id: UIA_EVENT_ID): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaRaiseAutomationEvent';
function UiaRaiseStructureChangedEvent(pProvider: IRawElementProviderSimple; structureChangeType: StructureChangeType; var pRuntimeId: Integer; cRuntimeIdLen: Integer): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaRaiseStructureChangedEvent';
function UiaRaiseAsyncContentLoadedEvent(pProvider: IRawElementProviderSimple; asyncContentLoadedState: AsyncContentLoadedState; percentComplete: Double): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaRaiseAsyncContentLoadedEvent';
function UiaRaiseTextEditTextChangedEvent(pProvider: IRawElementProviderSimple; textEditChangeType: TextEditChangeType; var pChangedData: SAFEARRAY): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaRaiseTextEditTextChangedEvent';
function UiaRaiseChangesEvent(pProvider: IRawElementProviderSimple; eventIdCount: Integer; var pUiaChanges: UiaChangeInfo): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaRaiseChangesEvent';
function UiaRaiseNotificationEvent(provider: IRawElementProviderSimple; notificationKind: NotificationKind; notificationProcessing: NotificationProcessing; displayString: PChar; activityId: PChar): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaRaiseNotificationEvent';
function UiaRaiseActiveTextPositionChangedEvent(provider: IRawElementProviderSimple; textRange: ITextRangeProvider): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaRaiseActiveTextPositionChangedEvent';
function UiaAddEvent(hnode: HUIANODE; eventId: Integer; var pCallback: UiaEventCallback; scope: TreeScope; var pProperties: Integer; cProperties: Integer; var pRequest: UiaCacheRequest; var phEvent: HUIAEVENT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaAddEvent';
function UiaRemoveEvent(hEvent: HUIAEVENT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaRemoveEvent';
function UiaEventAddWindow(hEvent: HUIAEVENT; hwnd: HWND): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaEventAddWindow';
function UiaEventRemoveWindow(hEvent: HUIAEVENT; hwnd: HWND): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaEventRemoveWindow';
function DockPattern_SetDockPosition(hobj: HUIAPATTERNOBJECT; dockPosition: DockPosition): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'DockPattern_SetDockPosition';
function ExpandCollapsePattern_Collapse(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'ExpandCollapsePattern_Collapse';
function ExpandCollapsePattern_Expand(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'ExpandCollapsePattern_Expand';
function GridPattern_GetItem(hobj: HUIAPATTERNOBJECT; row: Integer; column: Integer; var pResult: HUIANODE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'GridPattern_GetItem';
function InvokePattern_Invoke(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'InvokePattern_Invoke';
function MultipleViewPattern_GetViewName(hobj: HUIAPATTERNOBJECT; viewId: Integer; var ppStr: PChar): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'MultipleViewPattern_GetViewName';
function MultipleViewPattern_SetCurrentView(hobj: HUIAPATTERNOBJECT; viewId: Integer): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'MultipleViewPattern_SetCurrentView';
function RangeValuePattern_SetValue(hobj: HUIAPATTERNOBJECT; val: Double): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'RangeValuePattern_SetValue';
function ScrollItemPattern_ScrollIntoView(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'ScrollItemPattern_ScrollIntoView';
function ScrollPattern_Scroll(hobj: HUIAPATTERNOBJECT; horizontalAmount: ScrollAmount; verticalAmount: ScrollAmount): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'ScrollPattern_Scroll';
function ScrollPattern_SetScrollPercent(hobj: HUIAPATTERNOBJECT; horizontalPercent: Double; verticalPercent: Double): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'ScrollPattern_SetScrollPercent';
function SelectionItemPattern_AddToSelection(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'SelectionItemPattern_AddToSelection';
function SelectionItemPattern_RemoveFromSelection(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'SelectionItemPattern_RemoveFromSelection';
function SelectionItemPattern_Select(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'SelectionItemPattern_Select';
function TogglePattern_Toggle(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TogglePattern_Toggle';
function TransformPattern_Move(hobj: HUIAPATTERNOBJECT; x: Double; y: Double): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TransformPattern_Move';
function TransformPattern_Resize(hobj: HUIAPATTERNOBJECT; width: Double; height: Double): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TransformPattern_Resize';
function TransformPattern_Rotate(hobj: HUIAPATTERNOBJECT; degrees: Double): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TransformPattern_Rotate';
function ValuePattern_SetValue(hobj: HUIAPATTERNOBJECT; pVal: PChar): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'ValuePattern_SetValue';
function WindowPattern_Close(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'WindowPattern_Close';
function WindowPattern_SetWindowVisualState(hobj: HUIAPATTERNOBJECT; state: WindowVisualState): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'WindowPattern_SetWindowVisualState';
function WindowPattern_WaitForInputIdle(hobj: HUIAPATTERNOBJECT; milliseconds: Integer; var pResult: BOOL): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'WindowPattern_WaitForInputIdle';
function TextPattern_GetSelection(hobj: HUIAPATTERNOBJECT; var pRetVal: SAFEARRAY): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextPattern_GetSelection';
function TextPattern_GetVisibleRanges(hobj: HUIAPATTERNOBJECT; var pRetVal: SAFEARRAY): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextPattern_GetVisibleRanges';
function TextPattern_RangeFromChild(hobj: HUIAPATTERNOBJECT; hnodeChild: HUIANODE; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextPattern_RangeFromChild';
function TextPattern_RangeFromPoint(hobj: HUIAPATTERNOBJECT; point: UiaPoint; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextPattern_RangeFromPoint';
function TextPattern_get_DocumentRange(hobj: HUIAPATTERNOBJECT; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextPattern_get_DocumentRange';
function TextPattern_get_SupportedTextSelection(hobj: HUIAPATTERNOBJECT; var pRetVal: SupportedTextSelection): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextPattern_get_SupportedTextSelection';
function TextRange_Clone(hobj: HUIATEXTRANGE; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_Clone';
function TextRange_Compare(hobj: HUIATEXTRANGE; range: HUIATEXTRANGE; var pRetVal: BOOL): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_Compare';
function TextRange_CompareEndpoints(hobj: HUIATEXTRANGE; endpoint: TextPatternRangeEndpoint; targetRange: HUIATEXTRANGE; targetEndpoint: TextPatternRangeEndpoint; var pRetVal: Integer): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_CompareEndpoints';
function TextRange_ExpandToEnclosingUnit(hobj: HUIATEXTRANGE; &unit: TextUnit): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_ExpandToEnclosingUnit';
function TextRange_GetAttributeValue(hobj: HUIATEXTRANGE; attributeId: Integer; var pRetVal: OleVariant): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_GetAttributeValue';
function TextRange_FindAttribute(hobj: HUIATEXTRANGE; attributeId: Integer; val: OleVariant; backward: BOOL; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_FindAttribute';
function TextRange_FindText(hobj: HUIATEXTRANGE; text: PChar; backward: BOOL; ignoreCase: BOOL; var pRetVal: HUIATEXTRANGE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_FindText';
function TextRange_GetBoundingRectangles(hobj: HUIATEXTRANGE; var pRetVal: SAFEARRAY): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_GetBoundingRectangles';
function TextRange_GetEnclosingElement(hobj: HUIATEXTRANGE; var pRetVal: HUIANODE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_GetEnclosingElement';
function TextRange_GetText(hobj: HUIATEXTRANGE; maxLength: Integer; var pRetVal: PChar): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_GetText';
function TextRange_Move(hobj: HUIATEXTRANGE; &unit: TextUnit; count: Integer; var pRetVal: Integer): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_Move';
function TextRange_MoveEndpointByUnit(hobj: HUIATEXTRANGE; endpoint: TextPatternRangeEndpoint; &unit: TextUnit; count: Integer; var pRetVal: Integer): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_MoveEndpointByUnit';
function TextRange_MoveEndpointByRange(hobj: HUIATEXTRANGE; endpoint: TextPatternRangeEndpoint; targetRange: HUIATEXTRANGE; targetEndpoint: TextPatternRangeEndpoint): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_MoveEndpointByRange';
function TextRange_Select(hobj: HUIATEXTRANGE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_Select';
function TextRange_AddToSelection(hobj: HUIATEXTRANGE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_AddToSelection';
function TextRange_RemoveFromSelection(hobj: HUIATEXTRANGE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_RemoveFromSelection';
function TextRange_ScrollIntoView(hobj: HUIATEXTRANGE; alignToTop: BOOL): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_ScrollIntoView';
function TextRange_GetChildren(hobj: HUIATEXTRANGE; var pRetVal: SAFEARRAY): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'TextRange_GetChildren';
function ItemContainerPattern_FindItemByProperty(hobj: HUIAPATTERNOBJECT; hnodeStartAfter: HUIANODE; propertyId: Integer; value: OleVariant; var pFound: HUIANODE): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'ItemContainerPattern_FindItemByProperty';
function LegacyIAccessiblePattern_Select(hobj: HUIAPATTERNOBJECT; flagsSelect: Integer): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'LegacyIAccessiblePattern_Select';
function LegacyIAccessiblePattern_DoDefaultAction(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'LegacyIAccessiblePattern_DoDefaultAction';
function LegacyIAccessiblePattern_SetValue(hobj: HUIAPATTERNOBJECT; szValue: PChar): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'LegacyIAccessiblePattern_SetValue';
function LegacyIAccessiblePattern_GetIAccessible(hobj: HUIAPATTERNOBJECT; out pAccessible: IAccessible): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'LegacyIAccessiblePattern_GetIAccessible';
function SynchronizedInputPattern_StartListening(hobj: HUIAPATTERNOBJECT; inputType: SynchronizedInputType): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'SynchronizedInputPattern_StartListening';
function SynchronizedInputPattern_Cancel(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'SynchronizedInputPattern_Cancel';
function VirtualizedItemPattern_Realize(hobj: HUIAPATTERNOBJECT): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'VirtualizedItemPattern_Realize';
function UiaPatternRelease(hobj: HUIAPATTERNOBJECT): BOOL; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaPatternRelease';
function UiaTextRangeRelease(hobj: HUIATEXTRANGE): BOOL; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaTextRangeRelease';
function UiaReturnRawElementProvider(hwnd: HWND; wParam: WPARAM; lParam: LPARAM; el: IRawElementProviderSimple): LRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaReturnRawElementProvider';
function UiaHostProviderFromHwnd(hwnd: HWND; out ppProvider: IRawElementProviderSimple): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaHostProviderFromHwnd';
function UiaProviderForNonClient(hwnd: HWND; idObject: Integer; idChild: Integer; out ppProvider: IRawElementProviderSimple): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaProviderForNonClient';
function UiaIAccessibleFromProvider(pProvider: IRawElementProviderSimple; dwFlags: Cardinal; out ppAccessible: IAccessible; out pvarChild: OleVariant): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaIAccessibleFromProvider';
function UiaProviderFromIAccessible(pAccessible: IAccessible; idChild: Integer; dwFlags: Cardinal; out ppProvider: IRawElementProviderSimple): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaProviderFromIAccessible';
function UiaDisconnectAllProviders: HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaDisconnectAllProviders';
function UiaDisconnectProvider(pProvider: IRawElementProviderSimple): HRESULT; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaDisconnectProvider';
function UiaHasServerSideProvider(hwnd: HWND): BOOL; stdcall; external 'UIAutomationCore.dll' delayed name 'UiaHasServerSideProvider';

end.
