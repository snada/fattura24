# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#get_product' do
    let(:url) { 'https://www.app.fattura24.com/api/v0.3/GetProduct' }

    context 'with an invalid api key' do
      include_context 'invalid api key'

      before(:each) do
        stub_request(:post, url)
          .with(body: { apiKey: 'invalid' })
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns error' do
        expect(Fattura24::Api.get_product.to_h).to eq(invalid_api_key_response)
      end
    end

    context 'with a valid api key' do
      let(:all_xml) { File.read('spec/fixtures/all_products.xml') }
      let(:code_1_xml) { File.read('spec/fixtures/code_1_products.xml') }
      let(:category_2_xml) { File.read('spec/fixtures/category_2_products.xml') }

      before(:each) do
        Fattura24.configure do |c|
          c.api_key = 'valid'
        end

        stub_request(:post, url)
          .with(body: { apiKey: 'valid' })
          .to_return(status: 200, body: all_xml, headers: {})

        stub_request(:post, url)
          .with(body: { apiKey: 'valid', code: 'code1' })
          .to_return(status: 200, body: code_1_xml, headers: {})

        stub_request(:post, url)
          .with(body: { apiKey: 'valid', category: 'category2' })
          .to_return(status: 200, body: category_2_xml, headers: {})
      end

      it 'raises error when passing bad params' do
        expect { Fattura24::Api.get_product({ code: 'code', wrong: 'param' }) }
          .to raise_error(Fattura24::InvalidParams)
      end

      it 'returns a valid response' do
        expect(Fattura24::Api.get_product.to_h).to eq(
          root: {
            prodotto: [{
              id: '0000001',
              descrizione: 'Product1',
              testo: 'Text1',
              categoria: 'category1',
              codice: 'code1',
              nota: '',
              importo: '0.0',
              id_iva: '38',
              id_unita: '1',
              id_pdc_acquisto: '-1',
              id_pdc_vendita: '-1',
              mag_attivo: '0',
              mag_id_ubicazione: '0'
            }, {
              id: '0000002',
              descrizione: 'Product2',
              testo: 'text2',
              categoria: 'category2',
              codice: 'code2',
              nota: '',
              importo: '0.0',
              id_iva: '38',
              id_unita: '1',
              id_pdc_acquisto: '-1',
              id_pdc_vendita: '-1',
              mag_attivo: '0',
              mag_id_ubicazione: '0'
            }],
            magazzino: [{
              mag_id_ubicazione: '0',
              mag_scorta_minima: '0.0',
              mag_giacenza: 'null',
              mag_in_arrivo: 'null',
              mag_impegnata: 'null',
              mag_primo_carico: 'N.D.',
              mag_ultimo_carico: 'N.D.',
              mag_ultimo_scarico: 'N.D.'
            }, {
              mag_id_ubicazione: '0',
              mag_scorta_minima: '0.0',
              mag_giacenza: 'null',
              mag_in_arrivo: 'null',
              mag_impegnata: 'null',
              mag_primo_carico: 'N.D.',
              mag_ultimo_carico: 'N.D.',
              mag_ultimo_scarico: 'N.D.'
            }]
          }
        )
      end

      it 'filters when passing code' do
        expect(Fattura24::Api.get_product(code: 'code1').to_h).to eq(
          root: {
            prodotto: {
              id: '0000001',
              descrizione: 'Product1',
              testo: 'Text1',
              categoria: 'category1',
              codice: 'code1',
              nota: '',
              importo: '0.0',
              id_iva: '38',
              id_unita: '1',
              id_pdc_acquisto: '-1',
              id_pdc_vendita: '-1',
              mag_attivo: '0',
              mag_id_ubicazione: '0'
            },
            magazzino: {
              mag_id_ubicazione: '0',
              mag_scorta_minima: '0.0',
              mag_giacenza: 'null',
              mag_in_arrivo: 'null',
              mag_impegnata: 'null',
              mag_primo_carico: 'N.D.',
              mag_ultimo_carico: 'N.D.',
              mag_ultimo_scarico: 'N.D.'
            }
          }
        )
      end

      it 'filters when passing category' do
        expect(Fattura24::Api.get_product(category: 'category2').to_h).to eq(
          root: {
            prodotto: {
              id: '0000002',
              descrizione: 'Product2',
              testo: 'text2',
              categoria: 'category2',
              codice: 'code2',
              nota: '',
              importo: '0.0',
              id_iva: '38',
              id_unita: '1',
              id_pdc_acquisto: '-1',
              id_pdc_vendita: '-1',
              mag_attivo: '0',
              mag_id_ubicazione: '0'
            },
            magazzino: {
              mag_id_ubicazione: '0',
              mag_scorta_minima: '0.0',
              mag_giacenza: 'null',
              mag_in_arrivo: 'null',
              mag_impegnata: 'null',
              mag_primo_carico: 'N.D.',
              mag_ultimo_carico: 'N.D.',
              mag_ultimo_scarico: 'N.D.'
            }
          }
        )
      end
    end
  end
end
