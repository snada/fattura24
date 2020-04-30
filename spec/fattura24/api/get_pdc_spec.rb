# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#get_pdc' do
    let(:url) { 'https://www.app.fattura24.com/api/v0.3/GetPdc' }

    context 'with an invalid api key' do
      include_context 'invalid api key'

      it 'returns error' do
        expect(Fattura24::Api.get_pdc.to_h).to eq(invalid_api_key_response)
      end
    end

    context 'with a valid api key' do
      let(:xml) do
        <<~XML
          <root><pdc><id>000000</id><idProfilo>00000</idProfilo><parentId>null</parentId><idTipoConto>1</idTipoConto><idTipoSezione>1</idTipoSezione><idTipoPartitario>0</idTipoPartitario><ultimoLivello>null</ultimoLivello><codice><![CDATA[codice]]></codice><codiceExport><![CDATA[codiceexport]]></codiceExport><descrizione><![CDATA[descrizione]]></descrizione><descrizioneExport><![CDATA[descrizioneexport]]></descrizioneExport><attivo>1</attivo>\n</pdc></root>
        XML
      end

      before(:each) do
        Fattura24.configure do |c|
          c.api_key = 'valid'
        end

        stub_request(:post, url)
          .with(body: { apiKey: 'valid' })
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns a valid response' do
        expect(Fattura24::Api.get_pdc.to_h).to eq(
          root: {
            pdc: {
              id: '000000',
              id_profilo: '00000',
              parent_id: 'null',
              id_tipo_conto: '1',
              id_tipo_sezione: '1',
              id_tipo_partitario: '0',
              ultimo_livello: 'null',
              codice: 'codice',
              codice_export: 'codiceexport',
              descrizione: 'descrizione',
              descrizione_export: 'descrizioneexport',
              attivo: '1'
            }
          }
        )
      end
    end
  end
end
