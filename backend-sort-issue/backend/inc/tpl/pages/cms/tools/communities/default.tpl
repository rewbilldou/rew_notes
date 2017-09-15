<?php

// Un-authorized
if (empty($authorized)) {
	echo errorMsg('You do not have permission to access this page.', 'Authorization Error');
	return;
}

?>
<section>
	<header>
		<h1>Featured Communities (<?=number_format(count($manage_communities)); ?>)</h1>
		<div class="app_actions">
			<a class="ui-button positive" href="add/">Add Community</a>
		</div>
	</header>
	<section>
		<?php if (empty($manage_communities)) { ?>
			<p class="none">There are currently no featured communities.</p>
		<?php } else { ?>
			<table id="sortables" class="item_content_summaries">
				<thead>
					<tr>
						<th class="control" width="10">&nbsp;</th>
						<th>Featured Community</th>
						<th>Snippet</th>
						<th width="110">&nbsp;</th>
					</tr>
				</thead>
				<tbody>
					<?php foreach ($manage_communities as $community) { ?>
						<tr valign="top" id="items-<?=$community['id']; ?>">
							<td class="control" width="10"><a title="Drag to Sort" href="javascript:void(0);" class="handle">Move</a></td>
							<td>
								<div class="item_content_summary">
									<h4 class="item_content_title"><a href="edit/?id=<?=$community['id']; ?>">
										<?=Format::htmlspecialchars($community['title']); ?>
									</a></h4>
									<div class="item_content_additional">
										<b><?=Format::htmlspecialchars($community['subtitle']); ?></b>
										<?=(strlen($community['description']) > 100) ? substr($community['description'], 0, 100) . '...' : $community['description']; ?>
									</div>
									<div class="item_content_thumb">
										<?php if (!empty($community['image'])) { ?>
											<img src="/thumbs/60x60/uploads/<?=$community['image']; ?>" alt="">
										<?php } else { ?>
											<img src="/thumbs/60x60/uploads/listings/na.png" alt="">
										<?php }?>
									</div>
								</div>
							</td>
							<td nowrap="nowrap">#<?=Format::htmlspecialchars($community['snippet']); ?>#</td>
							<td class="actions compact">
								<a class="ui-button edit" href="edit/?id=<?=$community['id']; ?>">Edit</a>
								<a class="ui-button delete" href="?delete=<?=$community['id']; ?>" onclick="return confirm('Are you sure you want to delete this featured community?');">Delete</a>
							</td>
						</tr>
					<?php } ?>
				</tbody>
			</table>
			<?php ob_start(); ?>
			/* <script> */

				// D&D sorting for communities
				$('#sortables tbody').sortable({
					handle: '.handle',
					cursor: 'move',
					forceHelperSize: true,
					update: function(event, ui) {
					var items = $(this).sortable('serialize');
					// REWMOD - change from get to post since items is too long
                        // Note: if you are using a GET request there's a limit which will depend on the client browser
                        $.ajax({
                            url: '',
                            type: 'post',
                            dataType: 'json',
                            data: {
                                ajax: true,
                                order: true,
                                items: items
                            }
                        });
					},
					helper: function(e, tr) {
						var $originals = tr.children();
						var $helper = tr.clone();
						$helper.children().each(function(index) {
							$(this).width($originals.eq(index).width());
						});
						return $helper;
					}
				});

			/* </script> */
			<?php $page->addJavascript(ob_get_clean(), 'dynamic', true); ?>
		<?php } ?>
	</section>
</section>
