// Copyright 2014 The Beluga Project Developers. See the LICENCE.md
// file at the top-level directory of this distribution and at
// http://haxebeluga.github.io/licence.html.
//
// Licensed under the MIT License.
// This file may not be copied, modified, or distributed
// except according to those terms.

package beluga.module.market.widget;

import beluga.Beluga;
import beluga.widget.MttWidget;
import beluga.ConfigLoader;
import beluga.module.market.Market;
import beluga.widget.Layout;
import beluga.I18n;
import beluga.module.fileupload.Fileupload;
import beluga.module.account.Account;

class Admin extends MttWidget<Market> {

    public function new (?layout : Layout) {
        if(layout == null) layout = MttWidget.bootstrap.wrap("/beluga/module/market/view/tpl/admin.mtt");
        super(Market, layout);
        i18n = BelugaI18n.loadI18nFolder("/beluga/module/market/view/locale/admin/", mod.i18n);
    }

    override private function getContext(): Dynamic {
        var beluga = Beluga.getInstance();
        var images = new List<Dynamic>();
        var product_list = new List<Dynamic>();
        var error = "";
        var success = "";

        if (!beluga.getModuleInstance(Account).isLogged) {
            error = BelugaI18n.getKey(this.i18n, "user_not_logged");
        } else {
            error = this.getErrorString(this.mod.error);
            product_list = mod.getProductList();
            images = beluga.getModuleInstance(Fileupload).getUserFileList(beluga.getModuleInstance(Account).loggedUser.id);
        }

        return {
            error: error,
            success: this.getErrorString(this.mod.info),
            image_list: images,
            products_list: product_list,
            module_name: "Market admin"
        };
    }

    private function getErrorString(error: MarketErrorKind) {
        return switch(error) {
            case MarketOneMoreProductToCart(_): BelugaI18n.getKey(this.i18n, "one_more_product");
            case MarketNewProductToCart(_): BelugaI18n.getKey(this.i18n, "product_add_to_cart");
            case MarketUserNotLogged: BelugaI18n.getKey(this.i18n, "user_not_logged");
            case MarketUnknownProduct(_): BelugaI18n.getKey(this.i18n, "unknown_product");
            case MarketProductAlreadyExist(_): BelugaI18n.getKey(this.i18n, "product_already_exist");
            case MarketNewProductAdded(_): BelugaI18n.getKey(this.i18n, "new_prod");
            case MarketProductDeleted(_): BelugaI18n.getKey(this.i18n, "product_deleted");
            case MarketProductToShow(_): BelugaI18n.getKey(this.i18n, "product_deleted");
            case MarketNone: "";
        };
    }
}