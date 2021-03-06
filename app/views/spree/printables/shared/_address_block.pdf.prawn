bill_address = printable.bill_address
ship_address = printable.ship_address

address_cell_billing  = pdf.make_cell(content: Spree.t(:billing_address), font_style: :bold, :border_colors => ["eeeeee", "ffffff", "ffffff", "eeeeee"] )
address_cell_shipping = pdf.make_cell(content: Spree.t(:shipping_address), font_style: :bold, :border_colors => ["eeeeee", "eeeeee", "ffffff", "eeeeee"])

billing =  "#{bill_address.firstname} #{bill_address.lastname}"
billing << "\n#{bill_address.address1}"
billing << "\n#{bill_address.address2}" unless bill_address.address2.blank?
billing << "\n#{bill_address.city}, #{bill_address.state_text} #{bill_address.zipcode}"
billing << "\n#{bill_address.country.name}"
billing << "\n#{bill_address.phone}"

shipping =  "#{ship_address.firstname} #{ship_address.lastname}"
shipping << "\n#{ship_address.address1}"
shipping << "\n#{ship_address.address2}" unless ship_address.address2.blank?
shipping << "\n#{ship_address.city}, #{ship_address.state_text} #{ship_address.zipcode}"
shipping << "\n#{ship_address.country.name}"
shipping << "\n#{ship_address.phone}"
shipping << "\n\n#{Spree.t(:via, scope: :print_invoice)} #{printable.shipping_methods.join(", ")}"

billing_content = pdf.make_cell(content: billing, :border_colors => ["ffffff", "ffffff", "eeeeee", "eeeeee"])
shipping_content = pdf.make_cell(content: billing, :border_colors => ["ffffff", "eeeeee", "eeeeee", "eeeeee"])

data = [[address_cell_billing, address_cell_shipping], [billing_content, shipping_content]]

pdf.table(data, position: :center, column_widths: [pdf.bounds.width / 2, pdf.bounds.width / 2])
