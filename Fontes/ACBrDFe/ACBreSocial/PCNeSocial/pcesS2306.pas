{******************************************************************************}
{ Projeto: Componente ACBreSocial                                              }
{  Biblioteca multiplataforma de componentes Delphi para envio dos eventos do  }
{ eSocial - http://www.esocial.gov.br/                                         }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 27/10/2015: Jean Carlo Cantu, Tiago Ravache
|*  - Doa��o do componente para o Projeto ACBr
|* 01/03/2016: Guilherme Costa
|*  - Altera��es para valida��o com o XSD
******************************************************************************}
{$I ACBr.inc}

unit pcesS2306;

interface

uses
  SysUtils, Classes,
  pcnConversao, ACBrUtil,
  pcesCommon, pcesConversaoeSocial, pcesGerador;

type
  TS2306Collection = class;
  TS2306CollectionItem = class;
  TEvtTSVAltContr = class;
  TinfoTSVAlteracao = class;
  TinfoComplementares = class;

  TS2306Collection = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TS2306CollectionItem;
    procedure SetItem(Index: Integer; Value: TS2306CollectionItem);
  public
    function Add: TS2306CollectionItem;
    property Items[Index: Integer]: TS2306CollectionItem read GetItem write SetItem; default;
  end;

  TS2306CollectionItem = class(TCollectionItem)
  private
    FTipoEvento: TTipoEvento;
    FEvtTSVAltContr: TEvtTSVAltContr;

    procedure setEvtTSVAltContr(const Value: TEvtTSVAltContr);
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor  Destroy; override;
  published
    property TipoEvento: TTipoEvento read FTipoEvento;
    property EvtTSVAltContr: TEvtTSVAltContr read FEvtTSVAltContr write setEvtTSVAltContr;
  end;

  TEvtTSVAltContr = class(TeSocialEvento)
  private
    FIdeEvento: TIdeEvento2;
    FIdeEmpregador: TIdeEmpregador;
    FideTrabSemVinc: TideTrabSemVinc;
    FinfoTSVAlteracao : TinfoTSVAlteracao;
    FACBreSocial: TObject;

    procedure GerarideTrabSemVinc(obj : TideTrabSemVinc);
    procedure GerarInfoTSVAlteracao(obj: TinfoTSVAlteracao);
    procedure GerarinfoComplementares(obj: TinfoComplementares);
    procedure GerarinfoEstagiario(obj: TinfoEstagiario);
    procedure GerarInstEnsino(obj: TinstEnsino);
    procedure GerarageIntegracao(obj: TageIntegracao);
    procedure GerarsupervisorEstagio(obj: TsupervisorEstagio);
    procedure GerarcargoFuncao(obj: TcargoFuncao);
    procedure GerarRemuneracao(obj: TRemuneracao);
  public
    constructor Create(AACBreSocial: TObject); overload;
    destructor  Destroy; override;

    function GerarXML: boolean; override;
    function LerArqIni(const AIniString: String): Boolean;

    property IdeEvento: TIdeEvento2 read FIdeEvento write FIdeEvento;
    property IdeEmpregador: TIdeEmpregador read FIdeEmpregador write FIdeEmpregador;
    property IdeTrabSemVinc: TideTrabSemVinc read FideTrabSemVinc write FideTrabSemVinc;
    property infoTSVAlteracao : TinfoTSVAlteracao read FinfoTSVAlteracao write FinfoTSVAlteracao;
  end;

  TinfoTSVAlteracao = class(TPersistent)
  private
    FdtAlteracao : TDateTime;
    FnatAtividade: tpNatAtividade;
    FinfoComplementares : TinfoComplementares;
  public
    constructor Create;
    destructor  Destroy; override;

    property dtAlteracao : TDateTime read FdtAlteracao write FdtAlteracao;
    property natAtividade : tpNatAtividade read FnatAtividade write FnatAtividade;
    property infoComplementares : TinfoComplementares read FinfoComplementares write FinfoComplementares;
  end;

  TinfoComplementares = class(TPersistent)
  private
    FcargoFuncao : TcargoFuncao;
    FRemuneracao : TRemuneracao;
    FinfoEstagiario : TinfoEstagiario;
  public
    constructor Create;
    destructor  Destroy; override;

    property cargoFuncao: TcargoFuncao read FcargoFuncao write FcargoFuncao;
    property Remuneracao: TRemuneracao read FRemuneracao write FRemuneracao;
    property infoEstagiario: TinfoEstagiario read FinfoEstagiario write FinfoEstagiario;
  end;

implementation

uses
  IniFiles,
  ACBreSocial;

{ TS2306Collection }

function TS2306Collection.Add: TS2306CollectionItem;
begin
  Result := TS2306CollectionItem(inherited Add);
  Result.Create(TComponent(Self.Owner));
end;

function TS2306Collection.GetItem(Index: Integer): TS2306CollectionItem;
begin
  Result := TS2306CollectionItem(inherited GetItem(Index));
end;

procedure TS2306Collection.SetItem(Index: Integer; Value: TS2306CollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TS2306CollectionItem }

constructor TS2306CollectionItem.Create(AOwner: TComponent);
begin
  FTipoEvento := teS2306;
  FEvtTSVAltContr := TEvtTSVAltContr.Create(AOwner);
end;

destructor TS2306CollectionItem.Destroy;
begin
  FEvtTSVAltContr.Free;

  inherited;
end;

procedure TS2306CollectionItem.setEvtTSVAltContr(const Value: TEvtTSVAltContr);
begin
  FEvtTSVAltContr.Assign(Value);
end;

{ TinfoComplementares }

constructor TinfoComplementares.Create;
begin
  inherited;

  FcargoFuncao := TcargoFuncao.Create;
  FRemuneracao := TRemuneracao.Create;
  FinfoEstagiario := TinfoEstagiario.Create;
end;

destructor TinfoComplementares.Destroy;
begin
  FcargoFuncao.Free;
  FRemuneracao.Free;
  FinfoEstagiario.Free;

  inherited;
end;

{ TinfoTSVAlteracao }

constructor TinfoTSVAlteracao.Create;
begin
  inherited;

  FinfoComplementares := TinfoComplementares.Create;
end;

destructor TinfoTSVAlteracao.Destroy;
begin
  FinfoComplementares.Free;

  inherited;
end;

{ TEvtTSVAltContr }

constructor TEvtTSVAltContr.Create(AACBreSocial: TObject);
begin
  inherited;

  FACBreSocial := AACBreSocial;
  FIdeEvento := TIdeEvento2.Create;
  FIdeEmpregador := TIdeEmpregador.Create;
  FideTrabSemVinc := TideTrabSemVinc.Create;
  FinfoTSVAlteracao := TinfoTSVAlteracao.Create;
end;

destructor TEvtTSVAltContr.Destroy;
begin
  FIdeEvento.Free;
  FIdeEmpregador.Free;
  FIdeTrabSemVinc.Free;
  FinfoTSVAlteracao.Free;

  inherited;
end;

procedure TEvtTSVAltContr.GerarageIntegracao(obj: TageIntegracao);
begin
  if obj.cnpjAgntInteg <> EmptyStr then
  begin
    Gerador.wGrupo('ageIntegracao');

    Gerador.wCampo(tcStr, '', 'cnpjAgntInteg', 14,  14, 1, obj.cnpjAgntInteg);
    Gerador.wCampo(tcStr, '', 'nmRazao',        1, 100, 1, obj.nmRazao);
    Gerador.wCampo(tcStr, '', 'dscLograd',      1,  80, 1, obj.dscLograd);
    Gerador.wCampo(tcStr, '', 'nrLograd',       1,  10, 1, obj.nrLograd);
    Gerador.wCampo(tcStr, '', 'bairro',         1,  60, 0, obj.bairro);
    Gerador.wCampo(tcStr, '', 'cep',            1,   8, 1, obj.cep);
    Gerador.wCampo(tcStr, '', 'codMunic',       7,   7, 0, obj.codMunic);
    Gerador.wCampo(tcStr, '', 'uf',             2,   2, 1, eSufToStr(obj.uf));

    Gerador.wGrupo('/ageIntegracao');
  end;
end;

procedure TEvtTSVAltContr.GerarcargoFuncao(obj: TcargoFuncao);
begin
  if obj.codCargo <> '' then
  begin
    Gerador.wGrupo('cargoFuncao');

    Gerador.wCampo(tcStr, '', 'codCargo',  1, 30, 1, obj.codCargo);
    Gerador.wCampo(tcStr, '', 'codFuncao', 1, 30, 0, obj.codFuncao);

    Gerador.wGrupo('/cargoFuncao');
  end;
end;

procedure TEvtTSVAltContr.GerarideTrabSemVinc(obj: TideTrabSemVinc);
begin
  Gerador.wGrupo('ideTrabSemVinculo');

  Gerador.wCampo(tcStr, '', 'cpfTrab',  11, 11, 1, obj.cpfTrab);
  Gerador.wCampo(tcStr, '', 'nisTrab',   1, 11, 0, obj.nisTrab);
  Gerador.wCampo(tcStr, '', 'codCateg',  1,  3, 1, obj.codCateg);

  Gerador.wGrupo('/ideTrabSemVinculo');
end;

procedure TEvtTSVAltContr.GerarinfoComplementares(obj: TinfoComplementares);
begin
  if (obj.cargoFuncao.codCargo <> EmptyStr) or (obj.Remuneracao.VrSalFx > 0) or (obj.infoEstagiario.dtPrevTerm > 0) then
  begin
    Gerador.wGrupo('infoComplementares');

    GerarcargoFuncao(obj.cargoFuncao);
    GerarRemuneracao(obj.Remuneracao);
    GerarinfoEstagiario(obj.infoEstagiario);

    Gerador.wGrupo('/infoComplementares');
  end;
end;

procedure TEvtTSVAltContr.GerarinfoEstagiario(obj: TinfoEstagiario);
begin
  if obj.dtPrevTerm > 0 then
  begin
    Gerador.wGrupo('infoEstagiario');

    Gerador.wCampo(tcStr, '', 'natEstagio',   1,  1, 1, eSTpNatEstagioToStr(obj.natEstagio));
    Gerador.wCampo(tcStr, '', 'nivEstagio',   1,  1, 1, eStpNivelEstagioToStr(obj.nivEstagio));
    Gerador.wCampo(tcStr, '', 'areaAtuacao',  1, 50, 0, obj.areaAtuacao);
    Gerador.wCampo(tcStr, '', 'nrApol',       1, 30, 0, obj.nrApol);
    Gerador.wCampo(tcDe2, '', 'vlrBolsa',     1, 14, 0, obj.vlrBolsa);
    Gerador.wCampo(tcDat, '', 'dtPrevTerm',  10, 10, 1, obj.dtPrevTerm);

    GerarInstEnsino(obj.instEnsino);
    GerarageIntegracao(obj.ageIntegracao);
    GerarsupervisorEstagio(obj.supervisorEstagio);

    Gerador.wGrupo('/infoEstagiario');
  end;
end;

procedure TEvtTSVAltContr.GerarInfoTSVAlteracao(obj: TinfoTSVAlteracao);
begin
  Gerador.wGrupo('infoTSVAlteracao');

  Gerador.wCampo(tcDat, '', 'dtAlteracao',  10, 10, 1, obj.dtAlteracao);

  //    Valida��o: **Preenchimento obrigat�rio** para as categorias de avulso, cooperado e dirigente sindical.
  //               N�o deve ser preenchido para as categorias Diretor n�o empregado, servidor p�blico indicado a conselho, membro de conselho tutelar e estagi�rio.

  if
    (Self.FideTrabSemVinc.codCateg <> 305) and // Servidor Publico Indicado a Conselho
    (Self.FideTrabSemVinc.codCateg <> 721) and // Diretor n�o empregado com FGTS
    (Self.FideTrabSemVinc.codCateg <> 722) and // Diretor n�o empregado sem FGTS
    (Self.FideTrabSemVinc.codCateg <> 771) and // Membro conselho tutelar
    (Self.FideTrabSemVinc.codCateg <> 901) and // Estagiario
    (obj.natAtividade <> navNaoInformar)
  then
    Gerador.wCampo(tcStr, '', 'natAtividade',  1,  1, 0, eSNatAtividadeToStr(obj.natAtividade));

  GerarinfoComplementares(obj.infoComplementares);

  Gerador.wGrupo('/infoTSVAlteracao');
end;

procedure TEvtTSVAltContr.GerarInstEnsino(obj: TinstEnsino);
begin
  if obj.cnpjInstEnsino <> EmptyStr then
  begin
    Gerador.wGrupo('instEnsino');

    Gerador.wCampo(tcStr, '', 'cnpjInstEnsino', 14,  14, 0, obj.cnpjInstEnsino);
    Gerador.wCampo(tcStr, '', 'nmRazao',         1, 100, 1, obj.nmRazao);
    Gerador.wCampo(tcStr, '', 'dscLograd',       1,  80, 0, obj.dscLograd);
    Gerador.wCampo(tcStr, '', 'nrLograd',        1,  10, 0, obj.nrLograd);
    Gerador.wCampo(tcStr, '', 'bairro',          1,  60, 0, obj.bairro);
    Gerador.wCampo(tcStr, '', 'cep',             1,   8, 0, obj.cep);
    Gerador.wCampo(tcStr, '', 'codMunic',        7,   7, 0, obj.codMunic);
    Gerador.wCampo(tcStr, '', 'uf',              2,   2, 0, eSufToStr(obj.uf));

    Gerador.wGrupo('/instEnsino');
  end;
end;

procedure TEvtTSVAltContr.GerarRemuneracao(obj: TRemuneracao);
begin
  if obj.vrSalFx > 0 then
  begin
    Gerador.wGrupo('remuneracao');

    Gerador.wCampo(tcDe2, '', 'vrSalFx',    1,  14, 1, obj.vrSalFx);
    Gerador.wCampo(tcStr, '', 'undSalFixo', 1,   1, 1, eSUndSalFixoToStr(obj.undSalFixo));
    Gerador.wCampo(tcStr, '', 'dscSalVar',  1, 255, 0, obj.dscSalVar);

    Gerador.wGrupo('/remuneracao');
  end;
end;

procedure TEvtTSVAltContr.GerarsupervisorEstagio(obj: TsupervisorEstagio);
begin
  if obj.cpfSupervisor <> EmptyStr then
  begin
    Gerador.wGrupo('supervisorEstagio');

    Gerador.wCampo(tcStr, '', 'cpfSupervisor', 11, 11, 1, obj.cpfSupervisor);
    Gerador.wCampo(tcStr, '', 'nmSuperv',      1,  70, 1, obj.nmSuperv);

    Gerador.wGrupo('/supervisorEstagio');
  end;
end;

function TEvtTSVAltContr.GerarXML: boolean;
begin
  try
    Self.VersaoDF := TACBreSocial(FACBreSocial).Configuracoes.Geral.VersaoDF;
     
    Self.Id := GerarChaveEsocial(now, self.ideEmpregador.NrInsc, self.Sequencial);

    GerarCabecalho('evtTSVAltContr');
    Gerador.wGrupo('evtTSVAltContr Id="' + Self.Id + '"');

    GerarIdeEvento2(self.IdeEvento);
    GerarIdeEmpregador(self.IdeEmpregador);
    GerarideTrabSemVinc(self.IdeTrabSemVinc);
    GerarInfoTSVAlteracao(self.infoTSVAlteracao);

    Gerador.wGrupo('/evtTSVAltContr');

    GerarRodape;

    XML := Assinar(Gerador.ArquivoFormatoXML, 'evtTSVAltContr');

    Validar(schevtTSVAltContr);
  except on e:exception do
    raise Exception.Create('ID: ' + Self.Id + sLineBreak + ' ' + e.Message);
  end;

  Result := (Gerador.ArquivoFormatoXML <> '')
end;

function TEvtTSVAltContr.LerArqIni(const AIniString: String): Boolean;
var
  INIRec: TMemIniFile;
  Ok: Boolean;
  sSecao: String;
begin
  Result := False;

  INIRec := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(AIniString, INIRec);

    with Self do
    begin
      sSecao := 'evtTSVAltContr';
      Id         := INIRec.ReadString(sSecao, 'Id', '');
      Sequencial := INIRec.ReadInteger(sSecao, 'Sequencial', 0);

      sSecao := 'ideEvento';
      ideEvento.indRetif    := eSStrToIndRetificacao(Ok, INIRec.ReadString(sSecao, 'indRetif', '1'));
      ideEvento.NrRecibo    := INIRec.ReadString(sSecao, 'nrRecibo', EmptyStr);
      ideEvento.TpAmb       := eSStrTotpAmb(Ok, INIRec.ReadString(sSecao, 'tpAmb', '1'));
      ideEvento.ProcEmi     := eSStrToProcEmi(Ok, INIRec.ReadString(sSecao, 'procEmi', '1'));
      ideEvento.VerProc     := INIRec.ReadString(sSecao, 'verProc', EmptyStr);

      sSecao := 'ideEmpregador';
      ideEmpregador.OrgaoPublico := (TACBreSocial(FACBreSocial).Configuracoes.Geral.TipoEmpregador = teOrgaoPublico);
      ideEmpregador.TpInsc       := eSStrToTpInscricao(Ok, INIRec.ReadString(sSecao, 'tpInsc', '1'));
      ideEmpregador.NrInsc       := INIRec.ReadString(sSecao, 'nrInsc', EmptyStr);

      sSecao := 'ideTrabSemVinculo';
      ideTrabSemVinc.CpfTrab    := INIRec.ReadString(sSecao, 'cpfTrab', EmptyStr);
      ideTrabSemVinc.NisTrab    := INIRec.ReadString(sSecao, 'nisTrab', EmptyStr);
      ideTrabSemVinc.codCateg   := INIRec.ReadInteger(sSecao, 'codCateg', 0);

      sSecao := 'infoTSVAlteracao';
      infoTSVAlteracao.dtAlteracao    := StringToDateTime(INIRec.ReadString(sSecao, 'dtAlteracao', '0'));
      infoTSVAlteracao.natAtividade := eSStrToNatAtividade(Ok, INIRec.ReadString(sSecao, 'natAtividade', '1'));

      sSecao := 'infoComplementares';
      if INIRec.ReadString(sSecao, 'codCargo', '') <> '' then
      begin
        infoTSVAlteracao.infoComplementares.cargoFuncao.CodCargo  := INIRec.ReadString(sSecao, 'codCargo', '');
        infoTSVAlteracao.infoComplementares.cargoFuncao.CodFuncao := INIRec.ReadString(sSecao, 'codFuncao', '');
      end;

      sSecao := 'remuneracao';
      if INIRec.ReadString(sSecao, 'vrSalFx', '') <> '' then
      begin
        infoTSVAlteracao.infoComplementares.remuneracao.VrSalFx    := StringToFloatDef(INIRec.ReadString(sSecao, 'vrSalFx', ''), 0);
        infoTSVAlteracao.infoComplementares.remuneracao.UndSalFixo := eSStrToUndSalFixo(Ok, INIRec.ReadString(sSecao, 'undSalFixo', ''));
        infoTSVAlteracao.infoComplementares.remuneracao.DscSalVar  := INIRec.ReadString(sSecao, 'dscSalVar', '');
      end;

      sSecao := 'infoEstagiario';
      if INIRec.ReadString(sSecao, 'natEstagio', '') <> '' then
      begin
        infoTSVAlteracao.infoComplementares.infoEstagiario.natEstagio  := eSStrToTpNatEstagio(Ok, INIRec.ReadString(sSecao, 'natEstagio', 'O'));
        infoTSVAlteracao.infoComplementares.infoEstagiario.nivEstagio  := eSStrTotpNivelEstagio(Ok, INIRec.ReadString(sSecao, 'nivEstagio', '1'));
        infoTSVAlteracao.infoComplementares.infoEstagiario.areaAtuacao := INIRec.ReadString(sSecao, 'areaAtuacao', '');
        infoTSVAlteracao.infoComplementares.infoEstagiario.nrApol      := INIRec.ReadString(sSecao, 'nrApol', '');
        infoTSVAlteracao.infoComplementares.infoEstagiario.vlrBolsa    := StringToFloatDef(INIRec.ReadString(sSecao, 'vlrBolsa', ''), 0);
        infoTSVAlteracao.infoComplementares.infoEstagiario.dtPrevTerm  := StringToDateTime(INIRec.ReadString(sSecao, 'dtPrevTerm', '0'));

        sSecao := 'instEnsino';
        infoTSVAlteracao.infoComplementares.infoEstagiario.instEnsino.cnpjInstEnsino := INIRec.ReadString(sSecao, 'cnpjInstEnsino', '');
        infoTSVAlteracao.infoComplementares.infoEstagiario.instEnsino.nmRazao        := INIRec.ReadString(sSecao, 'nmRazao', '');
        infoTSVAlteracao.infoComplementares.infoEstagiario.instEnsino.dscLograd      := INIRec.ReadString(sSecao, 'dscLograd', '');
        infoTSVAlteracao.infoComplementares.infoEstagiario.instEnsino.nrLograd       := INIRec.ReadString(sSecao, 'nrLograd', '');
        infoTSVAlteracao.infoComplementares.infoEstagiario.instEnsino.bairro         := INIRec.ReadString(sSecao, 'bairro', '');
        infoTSVAlteracao.infoComplementares.infoEstagiario.instEnsino.Cep            := INIRec.ReadString(sSecao, 'cep', '');
        infoTSVAlteracao.infoComplementares.infoEstagiario.instEnsino.codMunic       := INIRec.ReadInteger(sSecao, 'codMunic', 0);
        infoTSVAlteracao.infoComplementares.infoEstagiario.instEnsino.uf             := eSStrTouf(Ok, INIRec.ReadString(sSecao, 'uf', 'SP'));

        sSecao := 'ageIntegracao';
        if INIRec.ReadString(sSecao, 'cnpjAgntInteg', '') <> '' then
        begin
          infoTSVAlteracao.infoComplementares.infoEstagiario.ageIntegracao.cnpjAgntInteg := INIRec.ReadString(sSecao, 'cnpjAgntInteg', '');
          infoTSVAlteracao.infoComplementares.infoEstagiario.ageIntegracao.nmRazao       := INIRec.ReadString(sSecao, 'nmRazao', '');
          infoTSVAlteracao.infoComplementares.infoEstagiario.ageIntegracao.dscLograd     := INIRec.ReadString(sSecao, 'dscLograd', '');
          infoTSVAlteracao.infoComplementares.infoEstagiario.ageIntegracao.nrLograd      := INIRec.ReadString(sSecao, 'nrLograd', '');
          infoTSVAlteracao.infoComplementares.infoEstagiario.ageIntegracao.bairro        := INIRec.ReadString(sSecao, 'bairro', '');
          infoTSVAlteracao.infoComplementares.infoEstagiario.ageIntegracao.Cep           := INIRec.ReadString(sSecao, 'cep', '');
          infoTSVAlteracao.infoComplementares.infoEstagiario.ageIntegracao.codMunic      := INIRec.ReadInteger(sSecao, 'codMunic', 0);
          infoTSVAlteracao.infoComplementares.infoEstagiario.ageIntegracao.uf            := eSStrTouf(Ok, INIRec.ReadString(sSecao, 'uf', 'SP'));
        end;

        sSecao := 'supervisorEstagio';
        if INIRec.ReadString(sSecao, 'cpfSupervisor', '') <> '' then
        begin
          infoTSVAlteracao.infoComplementares.infoEstagiario.supervisorEstagio.cpfSupervisor := INIRec.ReadString(sSecao, 'cpfSupervisor', '');
          infoTSVAlteracao.infoComplementares.infoEstagiario.supervisorEstagio.nmSuperv      := INIRec.ReadString(sSecao, 'nmSuperv', '');
        end;
      end;
    end;

    GerarXML;

    Result := True;
  finally
     INIRec.Free;
  end;
end;

end.
